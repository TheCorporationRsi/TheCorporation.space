// Openapi Generator last run: : 2024-12-08T02:21:15.411432
import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/screens/dashboard.dart';
import 'package:flutter_dashboard/screens/login_screen.dart';
import 'package:flutter_dashboard/screens/register_screen.dart';
import 'package:flutter_dashboard/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:flutter_dashboard/util/corp_interceptor.dart';
import 'package:dio/dio.dart';


//const corpApiUrl = "http://localhost:5000/api/apispec.json";
const corpApiUrl = "https://thecorporation.space/api/apispec.json";

@Openapi(
  additionalProperties:
      DioProperties(pubName: 'corp_api', pubAuthor: 'Cyber-Dreamer'),
  inputSpec:
      RemoteSpec(path: corpApiUrl),
  typeMappings: {'Pet': 'ExamplePet'},
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  skipIfSpecIsUnchanged: false,
  outputDirectory: 'api/corp_api',
)
class Example {}

void main() {
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final SecureStorageService secureStorage = new SecureStorageService();
final dio = Dio(BaseOptions(
              baseUrl: CorpApi.basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            ));
final corp_interceptor = AuthInterceptor(
    dio: dio,
    secureStorage: secureStorage,
    navigatorKey: navigatorKey,
  );

final CorpApi corpApi = CorpApi(interceptors: [corp_interceptor], dio: dio );

Future<String?> get _accessToken => secureStorage.read(key: 'corp_access_pass');

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CORP Dashboard',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/verification': (context) => const VerificationScreen(),
        '/dashboard': (context) => const MainScreen(),
      },
    );
  }
}