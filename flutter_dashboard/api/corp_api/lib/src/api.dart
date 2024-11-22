//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:corp_api/src/serializers.dart';
import 'package:corp_api/src/auth/api_key_auth.dart';
import 'package:corp_api/src/auth/basic_auth.dart';
import 'package:corp_api/src/auth/bearer_auth.dart';
import 'package:corp_api/src/auth/oauth.dart';
import 'package:corp_api/src/api/admin_api.dart';
import 'package:corp_api/src/api/influence_system_api.dart';
import 'package:corp_api/src/api/information_api.dart';
import 'package:corp_api/src/api/rsi_stats_api.dart';
import 'package:corp_api/src/api/security_api.dart';
import 'package:corp_api/src/api/structure_api.dart';

class CorpApi {
  static const String basePath = r'http://localhost:5000';

  final Dio dio;
  final Serializers serializers;

  CorpApi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor)
              as OAuthInterceptor)
          .tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor)
              as BearerAuthInterceptor)
          .tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor)
              as BasicAuthInterceptor)
          .authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this
                  .dio
                  .interceptors
                  .firstWhere((element) => element is ApiKeyAuthInterceptor)
              as ApiKeyAuthInterceptor)
          .apiKeys[name] = apiKey;
    }
  }

  /// Get AdminApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminApi getAdminApi() {
    return AdminApi(dio, serializers);
  }

  /// Get InfluenceSystemApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  InfluenceSystemApi getInfluenceSystemApi() {
    return InfluenceSystemApi(dio, serializers);
  }

  /// Get InformationApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  InformationApi getInformationApi() {
    return InformationApi(dio, serializers);
  }

  /// Get RSIStatsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RSIStatsApi getRSIStatsApi() {
    return RSIStatsApi(dio, serializers);
  }

  /// Get SecurityApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SecurityApi getSecurityApi() {
    return SecurityApi(dio, serializers);
  }

  /// Get StructureApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  StructureApi getStructureApi() {
    return StructureApi(dio, serializers);
  }
}
