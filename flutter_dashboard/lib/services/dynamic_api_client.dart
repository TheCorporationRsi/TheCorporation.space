import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dynamic API Client that parses OpenAPI spec and creates API calls
class DynamicApiClient {
  final Dio _dio;
  final String _baseUrl;
  Map<String, dynamic>? _apiSpec;
  Map<String, ApiEndpoint>? _endpoints;
  
  DynamicApiClient({
    required Dio dio,
    required String baseUrl,
  }) : _dio = dio, _baseUrl = baseUrl;

  /// Initialize the client by fetching and parsing the API spec
  Future<void> initialize() async {
    try {
      final response = await _dio.get('$_baseUrl/api/apispec.json');
      _apiSpec = response.data;
      _parseApiSpec();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load API spec: $e');
      }
      rethrow;
    }
  }

  /// Parse the OpenAPI specification into usable endpoints
  void _parseApiSpec() {
    if (_apiSpec == null) return;
    
    _endpoints = <String, ApiEndpoint>{};
    final paths = _apiSpec!['paths'] as Map<String, dynamic>?;
    
    if (paths == null) return;
    
    for (final pathEntry in paths.entries) {
      final path = pathEntry.key;
      final pathData = pathEntry.value as Map<String, dynamic>;
      
      for (final methodEntry in pathData.entries) {
        final method = methodEntry.key.toLowerCase();
        final methodData = methodEntry.value as Map<String, dynamic>;
        
        if (!['get', 'post', 'put', 'patch', 'delete'].contains(method)) {
          continue;
        }
        
        final operationId = methodData['operationId'] as String?;
        if (operationId == null) continue;
        
        final endpoint = ApiEndpoint(
          operationId: operationId,
          path: path,
          method: method,
          summary: methodData['summary'] as String?,
          description: methodData['description'] as String?,
          tags: _parseStringList(methodData['tags']),
          parameters: _parseParameters(methodData['parameters']),
          requestBody: _parseRequestBody(methodData['requestBody']),
          responses: _parseResponses(methodData['responses']),
          security: _parseSecurity(methodData['security']),
        );
        
        _endpoints![operationId] = endpoint;
      }
    }
  }

  /// Make an API call using the operation ID
  Future<Response<T>> call<T>(
    String operationId, {
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    final endpoint = _endpoints?[operationId];
    if (endpoint == null) {
      throw Exception('Operation $operationId not found in API spec');
    }

    // Build the path with parameters
    String path = endpoint.path;
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll('{$key}', value.toString());
      });
    }

    // Prepare request options
    final requestOptions = (options ?? Options()).copyWith(
      method: endpoint.method.toUpperCase(),
      headers: headers,
    );

    // Make the request
    return _dio.request<T>(
      path,
      data: data,
      queryParameters: queryParams,
      options: requestOptions,
    );
  }

  /// Get endpoint information by operation ID
  ApiEndpoint? getEndpoint(String operationId) {
    return _endpoints?[operationId];
  }

  /// Get all endpoints
  Map<String, ApiEndpoint>? get endpoints => _endpoints;

  /// Get endpoints by tag
  List<ApiEndpoint> getEndpointsByTag(String tag) {
    if (_endpoints == null) return [];
    return _endpoints!.values
        .where((endpoint) => endpoint.tags.contains(tag))
        .toList();
  }

  /// Check if the client is initialized
  bool get isInitialized => _apiSpec != null && _endpoints != null;

  // Helper methods for parsing

  List<String> _parseStringList(dynamic data) {
    if (data is List) {
      return data.whereType<String>().toList();
    }
    return [];
  }

  List<ApiParameter> _parseParameters(dynamic data) {
    if (data is! List) return [];
    
    return data.map<ApiParameter?>((param) {
      if (param is! Map<String, dynamic>) return null;
      
      return ApiParameter(
        name: param['name'] as String? ?? '',
        location: param['in'] as String? ?? '',
        required: param['required'] as bool? ?? false,
        description: param['description'] as String?,
        schema: param['schema'] as Map<String, dynamic>?,
      );
    }).whereType<ApiParameter>().toList();
  }

  ApiRequestBody? _parseRequestBody(dynamic data) {
    if (data is! Map<String, dynamic>) return null;
    
    final content = data['content'] as Map<String, dynamic>?;
    if (content == null) return null;
    
    return ApiRequestBody(
      description: data['description'] as String?,
      required: data['required'] as bool? ?? false,
      content: content,
    );
  }

  Map<String, ApiResponse> _parseResponses(dynamic data) {
    if (data is! Map<String, dynamic>) return {};
    
    final responses = <String, ApiResponse>{};
    
    for (final entry in data.entries) {
      final statusCode = entry.key;
      final responseData = entry.value as Map<String, dynamic>?;
      
      if (responseData != null) {
        responses[statusCode] = ApiResponse(
          description: responseData['description'] as String?,
          content: responseData['content'] as Map<String, dynamic>?,
        );
      }
    }
    
    return responses;
  }

  List<Map<String, dynamic>> _parseSecurity(dynamic data) {
    if (data is! List) return [];
    
    return data.whereType<Map<String, dynamic>>().toList();
  }
}

/// Represents an API endpoint
class ApiEndpoint {
  final String operationId;
  final String path;
  final String method;
  final String? summary;
  final String? description;
  final List<String> tags;
  final List<ApiParameter> parameters;
  final ApiRequestBody? requestBody;
  final Map<String, ApiResponse> responses;
  final List<Map<String, dynamic>> security;

  const ApiEndpoint({
    required this.operationId,
    required this.path,
    required this.method,
    this.summary,
    this.description,
    required this.tags,
    required this.parameters,
    this.requestBody,
    required this.responses,
    required this.security,
  });

  /// Get path parameters
  List<ApiParameter> get pathParameters =>
      parameters.where((p) => p.location == 'path').toList();

  /// Get query parameters
  List<ApiParameter> get queryParameters =>
      parameters.where((p) => p.location == 'query').toList();

  /// Get header parameters
  List<ApiParameter> get headerParameters =>
      parameters.where((p) => p.location == 'header').toList();

  /// Check if endpoint requires authentication
  bool get requiresAuth => security.isNotEmpty;

  @override
  String toString() {
    return 'ApiEndpoint(operationId: $operationId, method: $method, path: $path)';
  }
}

/// Represents an API parameter
class ApiParameter {
  final String name;
  final String location; // path, query, header, cookie
  final bool required;
  final String? description;
  final Map<String, dynamic>? schema;

  const ApiParameter({
    required this.name,
    required this.location,
    required this.required,
    this.description,
    this.schema,
  });

  /// Get the parameter type from schema
  String? get type => schema?['type'] as String?;

  /// Get example value
  dynamic get example => schema?['example'];

  @override
  String toString() {
    return 'ApiParameter(name: $name, location: $location, type: $type, required: $required)';
  }
}

/// Represents request body information
class ApiRequestBody {
  final String? description;
  final bool required;
  final Map<String, dynamic> content;

  const ApiRequestBody({
    this.description,
    required this.required,
    required this.content,
  });

  /// Get JSON schema if available
  Map<String, dynamic>? get jsonSchema {
    final jsonContent = content['application/json'] as Map<String, dynamic>?;
    return jsonContent?['schema'] as Map<String, dynamic>?;
  }
}

/// Represents an API response
class ApiResponse {
  final String? description;
  final Map<String, dynamic>? content;

  const ApiResponse({
    this.description,
    this.content,
  });

  /// Get JSON schema for response if available
  Map<String, dynamic>? get jsonSchema {
    final jsonContent = content?['application/json'] as Map<String, dynamic>?;
    return jsonContent?['schema'] as Map<String, dynamic>?;
  }
}
