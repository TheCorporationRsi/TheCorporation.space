// Dynamic API Client implementation - replaces OpenAPI Generator
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/screens/dashboard.dart';
import 'package:flutter_dashboard/screens/login_screen.dart';
import 'package:flutter_dashboard/screens/register_screen.dart';
import 'package:flutter_dashboard/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/services/service_locator.dart';

// Dynamic API URL based on current domain
String get corpApiUrl {
  // For web, use the current domain
  if (kIsWeb) {
    final currentUrl = Uri.base;
    return '${currentUrl.scheme}://${currentUrl.host}${currentUrl.hasPort ? ':${currentUrl.port}' : ''}';
  }
  // For development/debug builds, use localhost
  return "http://localhost:5000";
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final navigatorKey = GlobalKey<NavigatorState>();
  
  // Pre-initialize only essential services for faster startup
  await ServiceLocator().preInitialize(
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
      // Use onGenerateRoute for lazy loading
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/verification':
            return MaterialPageRoute(builder: (_) => const VerificationScreen());
          case '/dashboard':
            // Lazy load dashboard - only initialize API client when needed
            return MaterialPageRoute(
              builder: (_) => FutureBuilder(
                future: _ensureFullInitialization(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      backgroundColor: backgroundColor,
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: primaryColor),
                            SizedBox(height: 16),
                            Text(
                              'Loading Dashboard...',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Scaffold(
                      backgroundColor: backgroundColor,
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, color: Colors.red, size: 48),
                            SizedBox(height: 16),
                            Text(
                              'Failed to load dashboard',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${snapshot.error}',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                              child: Text('Return to Login'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const MainScreen();
                },
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
  
  /// Ensures full API client initialization only when accessing dashboard
  Future<void> _ensureFullInitialization() async {
    if (!ServiceLocator().isFullyInitialized) {
      await ServiceLocator().completeInitialization();
    }
  }
}
