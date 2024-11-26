import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:corp_api/corp_api.dart';

typedef TokenPair = ({String accessToken, String refreshToken});

class RevokeTokenException extends DioException {
  RevokeTokenException({required super.requestOptions});
}

class AuthInterceptor extends QueuedInterceptor {
  /// Create an Auth interceptor
  AuthInterceptor({
    required this.dio,
    required this.secureStorage,
    this.shouldClearBeforeReset = true,
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    refreshClient = Dio();
    refreshClient.options = BaseOptions(baseUrl: dio.options.baseUrl);

    retryClient = Dio();
    retryClient.options = BaseOptions(baseUrl: dio.options.baseUrl);
  }

  final Dio dio;
  final secure_storage.FlutterSecureStorage secureStorage;
  final bool shouldClearBeforeReset;
  late final Dio refreshClient;
  late final Dio retryClient;
  late final  GlobalKey<NavigatorState> navigatorKey;

  final corpSecurityClient = CorpApi().getSecurityApi();

  Future<String?> get _accessToken => secureStorage.read(key: 'accessToken');

  Future<String?> get _refreshToken => secureStorage.read(key: 'refreshToken');

  Future<TokenPair?> _getTokenPair() async {
    final accessToken = await _accessToken;
    final refreshToken = await _refreshToken;

    if (accessToken != null && refreshToken != null) {
      return (accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  Future<void> _saveTokenPair(TokenPair tokenPair) async {
    await secureStorage.write(
      key: 'accessToken',
      value: tokenPair.accessToken,
    );
    await secureStorage.write(
      key: 'refreshToken',
      value: tokenPair.refreshToken,
    );
  }

  Future<void> _clearTokenPair() async {
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');
  }

  Future<Map<String, dynamic>> _buildHeaders() async {
    final tokenPair = await _getTokenPair();

    return {
      'Authorization': 'Bearer ${tokenPair!.accessToken}',
    };
  }

  /// Check if the token pair should be refreshed
  @visibleForTesting
  @pragma('vm:prefer-inline')
  bool shouldRefresh<R>(Response<R>? response) => response?.statusCode == 401;

  Future<bool> get _isAccessTokenValid async {
    final tokenPair = await _getTokenPair();

    if (tokenPair == null) {
      return false;
    }

    final decodedJwt = JWT.decode(tokenPair.accessToken);
    final expirationTimeEpoch = decodedJwt.payload['exp'];
    final expirationDateTime =
        DateTime.fromMillisecondsSinceEpoch(expirationTimeEpoch * 1000);

    final marginOfErrorInMilliseconds = 1000; // appr 1 seconds
    final addedMarginTime = Duration(milliseconds: marginOfErrorInMilliseconds);

    return DateTime.now().add(addedMarginTime).isBefore(expirationDateTime);
  }

  Future<TokenPair?> _refresh({
    required RequestOptions options,
    TokenPair? tokenPair,
  }) async {
    if (tokenPair == null) {
      throw RevokeTokenException(requestOptions: options);
    }
    final headers = {
      'Authorization': 'Bearer ${tokenPair.refreshToken}',
    };

    corpSecurityClient.refreshToken(headers: headers).then((response) {
      print(response);

      if (response.data!.refreshed == true) {
        TokenPair newTokenPair;

        if (response.data!.corpRefreshPass == null) {
          newTokenPair = (
            accessToken: response.data!.corpAccessPass,
            refreshToken: tokenPair.refreshToken,
          ) as TokenPair;
        } else {
          newTokenPair = (
            accessToken: response.data!.corpAccessPass,
            refreshToken: response.data!.corpRefreshPass,
          ) as TokenPair;
        }

        if (shouldClearBeforeReset) {
          _clearTokenPair();
        }

        _saveTokenPair(newTokenPair);
        return newTokenPair;
      } else {
        _clearTokenPair();
        throw RevokeTokenException(requestOptions: options);
      }
    }).catchError((error) {
      _clearTokenPair();
      throw RevokeTokenException(requestOptions: options);
    });
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
        headers: requestOptions.headers..addAll(await _buildHeaders()),
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
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err is RevokeTokenException) {
      /// call the session expire logic for your state management
      navigatorKey.currentState?.pushNamed('/login');
      return handler.reject(err);
    }

    if (!shouldRefresh(err.response)) {
      return handler.next(err);
    }

    final isAccessValid = await _isAccessTokenValid;
    final tokenPair = await _getTokenPair();

    if (tokenPair == null) {
      return handler.reject(err);
    }

    try {
      if (isAccessValid) {
        final previousRequest = await _retry(err.requestOptions);
        return handler.resolve(previousRequest);
      } else {
        await _refresh(options: err.requestOptions, tokenPair: tokenPair);
        final previousRequest = await _retry(err.requestOptions);
        return handler.resolve(previousRequest);
      }
    } on RevokeTokenException {
      /// call the session expire logic for your state management
      return handler.reject(err);
    } on DioException catch (err) {
      return handler.next(err);
    }
  }
}
