import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dashboard/services/dynamic_api_client.dart';
import 'package:flutter_dashboard/services/corp_api_service.dart';
import 'package:flutter_dashboard/util/corp_interceptor.dart';

/// Service locator for managing global services with optimized lazy loading
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final Dio _dio;
  DynamicApiClient? _dynamicApiClient;
  CorpApiService? _corpApiService;
  late final SecureStorageService _secureStorage;
  late final AuthInterceptor _authInterceptor;
  late final GlobalKey<NavigatorState> _navigatorKey;
  late final String _baseUrl;

  bool _isPreInitialized = false;
  bool _isFullyInitialized = false;

  /// Pre-initialize only essential services for fast startup
  Future<void> preInitialize({
    required String baseUrl,
    required GlobalKey<NavigatorState> navigatorKey,
  }) async {
    if (_isPreInitialized) return;

    _baseUrl = baseUrl;
    _navigatorKey = navigatorKey;
    _secureStorage = SecureStorageService();

    // Initialize Dio with minimal configuration
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ));

    // Initialize auth interceptor
    _authInterceptor = AuthInterceptor(
      dio: _dio,
      secureStorage: _secureStorage,
      navigatorKey: _navigatorKey,
    );

    // Add interceptor to Dio
    _dio.interceptors.add(_authInterceptor);

    _isPreInitialized = true;
  }

  /// Complete initialization when API client is actually needed
  Future<void> completeInitialization() async {
    if (_isFullyInitialized || !_isPreInitialized) return;

    // Initialize dynamic API client
    _dynamicApiClient = DynamicApiClient(
      dio: _dio,
      baseUrl: _baseUrl,
    );

    // Initialize the API spec
    await _dynamicApiClient!.initialize();

    // Initialize the API service
    _corpApiService = CorpApiService(_dynamicApiClient!);

    _isFullyInitialized = true;
  }

  /// Legacy initialize method for backward compatibility
  Future<void> initialize({
    required String baseUrl,
    required GlobalKey<NavigatorState> navigatorKey,
  }) async {
    await preInitialize(baseUrl: baseUrl, navigatorKey: navigatorKey);
    await completeInitialization();
  }

  /// Get the Dio instance
  Dio get dio {
    _ensurePreInitialized();
    return _dio;
  }

  /// Get the dynamic API client (lazy loaded)
  DynamicApiClient get dynamicApiClient {
    _ensureFullyInitialized();
    return _dynamicApiClient!;
  }

  /// Get the Corp API service (lazy loaded)
  CorpApiService get corpApiService {
    _ensureFullyInitialized();
    return _corpApiService!;
  }

  /// Get the secure storage service
  SecureStorageService get secureStorage {
    _ensurePreInitialized();
    return _secureStorage;
  }

  /// Get the auth interceptor
  AuthInterceptor get authInterceptor {
    _ensurePreInitialized();
    return _authInterceptor;
  }

  /// Get the navigator key
  GlobalKey<NavigatorState> get navigatorKey {
    _ensurePreInitialized();
    return _navigatorKey;
  }

  /// Check if services are pre-initialized
  bool get isPreInitialized => _isPreInitialized;
  
  /// Check if services are fully initialized
  bool get isFullyInitialized => _isFullyInitialized;

  /// Legacy compatibility
  bool get isInitialized => _isFullyInitialized;

  void _ensurePreInitialized() {
    if (!_isPreInitialized) {
      throw StateError('ServiceLocator must be pre-initialized before use');
    }
  }

  void _ensureFullyInitialized() {
    if (!_isFullyInitialized) {
      throw StateError('ServiceLocator must be fully initialized before accessing API services');
    }
  }

  /// Reset all services (for testing or logout)
  void reset() {
    _isPreInitialized = false;
    _isFullyInitialized = false;
    _dynamicApiClient = null;
    _corpApiService = null;
  }
}
