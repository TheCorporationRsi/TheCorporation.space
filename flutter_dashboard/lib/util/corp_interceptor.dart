import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mutex/mutex.dart';

typedef TokenPair = ({String accessToken, String refreshToken});

class RevokeTokenException extends DioException {
  RevokeTokenException({required super.requestOptions});
}

class SecureStorageService {
  final secure_storage.FlutterSecureStorage _secureStorage = secure_storage.FlutterSecureStorage();
  final Mutex _mutex = Mutex();

  Future<void> write({
    required String key,
    required String? value,
  }) async {
    await _mutex.acquire();
    try {
      await _secureStorage.write(key: key, value: value);
    } finally {
      _mutex.release();
    }
  }

  Future<String?> read({
    required String key,
  }) async {
    await _mutex.acquire();
    try {
      return await _secureStorage.read(key: key);
    } finally {
      _mutex.release();
    }
  }

  Future<void> delete({
    required String key,
  }) async {
    await _mutex.acquire();
    try {
      await _secureStorage.delete(key: key);
    } finally {
      _mutex.release();
    }
  }
}

class AuthInterceptor extends QueuedInterceptor {
  /// Create an Auth interceptor
  AuthInterceptor({
    required this.dio,
    required this.secureStorage,
    this.shouldClearBeforeReset = false,
    required GlobalKey<NavigatorState> navigatorKey,
  }) : navigatorKey = navigatorKey {
    refreshClient = Dio();
    refreshClient.options = BaseOptions(baseUrl: dio.options.baseUrl);

    retryClient = Dio();
    retryClient.options = BaseOptions(baseUrl: dio.options.baseUrl);
    
    // Use the same base URL as the main dio client for security operations
    corpSecurityClient = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
  }

  final Dio dio;
  final SecureStorageService secureStorage;
  final bool shouldClearBeforeReset;
  late final Dio refreshClient;
  late final Dio retryClient;
  final GlobalKey<NavigatorState> navigatorKey;

  late final Dio corpSecurityClient;
  final Mutex _errorMutex = Mutex();

  Future<String?> get _accessToken => secureStorage.read(key: 'corp_access_pass');

  Future<String?> get _refreshToken => secureStorage.read(key: 'corp_refresh_pass');

  Future<void> _saveAccessToken(String accessToken) async {
    await secureStorage.write(
      key: 'corp_access_pass',
      value: accessToken,
    );
  }

  Future<void> _saveRefreshToken(String refreshToken) async {
    await secureStorage.write(
      key: 'corp_refresh_pass',
      value: refreshToken,
    );
  }

  Future<void> _clearAccessToken() async {
    await secureStorage.delete(key: 'corp_access_pass');
  }

  Future<void> _clearRefreshToken() async {
    await secureStorage.delete(key: 'corp_refresh_pass');
  }

  Future<Map<String, dynamic>?> getAuthHeader() async {
    final accessToken = await _accessToken;

    if (accessToken != null) {
      return {
      'Authorization': 'Bearer $accessToken',
      };
    }
    else {
      return null;
    }
  }

  /// Check if the token pair should be refreshed
  @visibleForTesting
  @pragma('vm:prefer-inline')
  bool shouldRefresh<R>(Response<R>? response) => response?.statusCode == 401;

  Future<bool> get _isAccessTokenValid async {
    final accessToken = await _accessToken;

    if (accessToken == null) {
      return false;
    }

    final decodedJwt = JWT.decode(accessToken);
    final expirationTimeEpoch = decodedJwt.payload['exp'];
    final expirationDateTime =
        DateTime.fromMillisecondsSinceEpoch(expirationTimeEpoch * 1000);

    final marginOfErrorInMilliseconds = 1000; // appr 1 seconds
    final addedMarginTime = Duration(milliseconds: marginOfErrorInMilliseconds);

    return DateTime.now().add(addedMarginTime).isBefore(expirationDateTime);
  }

  Future<void> _refresh({
    required RequestOptions options,
  }) async {
    print("refreshing tokens...");
    final refreshToken = await _refreshToken;
    if (refreshToken == null) {
      throw RevokeTokenException(requestOptions: options);
    }
    final headers = {
      'Authorization': 'Bearer $refreshToken',
    };
      try {
      final response = await corpSecurityClient.post(
        '/api/v0/refresh_token',
        options: Options(headers: headers),
      );
      print(response);

      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final refreshed = data['refreshed'] as bool?;
        
        if (refreshed == true) {
          final newAccessToken = data['corp_access_pass'] as String?;
          final newRefreshToken = data['corp_refresh_pass'] as String?;
          
          if (newAccessToken != null) {
            await _saveAccessToken(newAccessToken);
          }
          if (newRefreshToken != null) {
            await _saveRefreshToken(newRefreshToken);
          }
          print('Token refreshed');
        } else {
          await _clearAccessToken();
          await _clearRefreshToken();
          throw RevokeTokenException(requestOptions: options);
        }
      } else {
        await _clearAccessToken();
        await _clearRefreshToken();
        throw RevokeTokenException(requestOptions: options);
      }
    }catch (error) {
      throw RevokeTokenException(requestOptions: options);
    };
  }

  Future<Response<R>> _retry<R>(
    RequestOptions requestOptions,
  ) async {
    return retryClient.request<R>(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data is FormData
          ? (requestOptions.data as FormData).clone()
          : requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        headers: (await getAuthHeader()) ?? {},
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        maxRedirects: requestOptions.maxRedirects,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        listFormat: requestOptions.listFormat,
      ),
    );
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add authorization header to all requests if available
    final authHeader = await getAuthHeader();
    if (authHeader != null) {
      options.headers.addAll(authHeader);
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    await _errorMutex.acquire();
    try {
      if (err is RevokeTokenException) {
        /// call the session expire logic for your state management
        return handler.reject(err);
      }

      if (!shouldRefresh(err.response)) {
        return handler.next(err);
      }

      
      final accessToken = await _accessToken;
      final refreshToken = await _refreshToken;
      

      if (accessToken == null || refreshToken == null) {
        _clearAccessToken();
        _clearRefreshToken();
        return handler.reject(err);
      }

      final isAccessValid = await _isAccessTokenValid;

      try {
        if (isAccessValid) {
          print("Access is valid...");
          final previousRequest = await _retry(err.requestOptions);
          return handler.resolve(previousRequest);
        } else {
          print("Access is invalid, trying to refresh...");
          await _refresh(options: err.requestOptions);
          final previousRequest = await _retry(err.requestOptions);
          return handler.resolve(previousRequest);
        }
      } on RevokeTokenException {
        print("Token expired...");
        /// call the session expire logic for your state management
        await _clearAccessToken();
        await _clearRefreshToken();
        navigatorKey.currentState?.pushNamed('/login');
        return handler.reject(err);
      } on DioException catch (err) {
        print(err);
        print("Returning error...");
        return handler.next(err);
      }
    } finally {
      _errorMutex.release();
    }
  }
}
