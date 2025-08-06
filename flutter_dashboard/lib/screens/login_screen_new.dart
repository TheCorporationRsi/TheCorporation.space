import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widgets/security/content/security_form_widget.dart';
import 'package:flutter_dashboard/services/service_locator.dart';
import 'package:flutter_dashboard/services/asset_preloader.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<void> writeSecureData(String key, String value) async {
  try {
    await secureStorage.write(key: key, value: value);
    final token = await secureStorage.read(key: key);
    if (token == null) {
      print("token saved!");
    }
  } catch (e) {
    print(e);
    print("token not saved!");
  }
}

String _hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController handleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController OTPController = TextEditingController();
  bool _isLoading = false;

  final GlobalKey<SecurityFormWidgetState> _securityFormKey =
      GlobalKey<SecurityFormWidgetState>();
  
  @override
  void initState() {
    super.initState();
    _initialize();
  }
  
  Future<void> _initialize() async {
    // Preload critical assets in background
    AssetPreloader().preloadCriticalAssets();
    
    // Check if user is already logged in
    await _checkExistingSession();
    await checkSecurityLevel(context, 'NotLoggedIn');
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _checkExistingSession() async {
    try {
      final accessToken = await secureStorage.read(key: 'corp_access_pass');
      if (accessToken != null) {
        // User might be already logged in, redirect to dashboard
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    } catch (e) {
      print('Error checking existing session: $e');
    }
  }

  @override
  void dispose() {
    handleController.dispose();
    passwordController.dispose();
    OTPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: SecurityFormWidget(
        key: _securityFormKey,
        formTitle: 'Login',
        controller1: handleController,
        controller2: passwordController,
        controller3: OTPController,
        textFieldTitle1: 'RSI Handle',
        textFieldTitle2: 'Password',
        textFieldTitle3: 'One-Time Password (Optional)',
        buttonTitle1: 'Login',
        buttonTitle2: 'Register',
        buttonTitle3: 'Forgot Password?',
        buttonAction1: () async {
          setState(() {
            _isLoading = true;
          });

          try {
            // Ensure API client is fully initialized
            await ServiceLocator().completeInitialization();
            
            final otp = OTPController.text.isEmpty
                ? null
                : int.tryParse(OTPController.text);

            final apiService = ServiceLocator().corpApiService;
            final response = await apiService.login(
              username: handleController.text,
              password: _hashPassword(passwordController.text),
              otp: otp,
            );

            if (response.data != null && response.data['msg'] == 'logged_in') {
              final accessToken = response.data['corp_access_pass'];
              final refreshToken = response.data['corp_refresh_pass'];

              if (refreshToken != null) {
                await writeSecureData('corp_refresh_pass', refreshToken);
              }

              if (accessToken != null) {
                await writeSecureData('corp_access_pass', accessToken);
              }

              // Preload additional assets for dashboard
              if (mounted) {
                AssetPreloader().preloadAdditionalAssets(context);
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            } else {
              _securityFormKey.currentState?.showError("Login error, try again later");
            }
          } catch (error) {
            if (error.toString().contains('400')) {
              try {
                final errorMsg = jsonDecode(error.toString())['msg'] ?? 'Login failed';
                _securityFormKey.currentState?.showError(errorMsg);
              } catch (e) {
                _securityFormKey.currentState?.showError("Invalid credentials");
              }
            } else {
              _securityFormKey.currentState?.showError("Network error, please try again");
              print('Login error: $error');
            }
          } finally {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          }
        },
        buttonAction2: () {
          Navigator.pushNamed(context, '/register');
        },
        buttonAction3: () {
          // Implement forgot password functionality
          _securityFormKey.currentState?.showError("Forgot password functionality coming soon");
        },
        isLoading: _isLoading,
      ),
    );
  }
}
