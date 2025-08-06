// Dynamic API Client implementation - replaces OpenAPI Generator
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/screens/dashboard.dart';
import 'package:flutter_dashboard/screens/login_screen.dart';
import 'package:flutter_dashboard/screens/register_screen.dart';
import 'package:flutter_dashboard/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/services/service_locator.dart';

//const corpApiUrl = "http://localhost:5000";
const corpApiUrl = "https://thecorporation.space";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final navigatorKey = GlobalKey<NavigatorState>();
  
  // Initialize services
  await ServiceLocator().initialize(
    baseUrl: corpApiUrl,
    navigatorKey: navigatorKey,
  );
  
  runApp(MyApp(navigatorKey: navigatorKey));
}

// Legacy getters for backward compatibility
GlobalKey<NavigatorState> get navigatorKey => ServiceLocator().navigatorKey;
get secureStorage => ServiceLocator().secureStorage;
get corpApiService => ServiceLocator().corpApiService;

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
  final GlobalKey<NavigatorState> navigatorKey;
  
  const MyApp({super.key, required this.navigatorKey});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheCorporation',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        
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
