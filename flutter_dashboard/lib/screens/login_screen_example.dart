import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widgets/security/content/security_form_widget.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

Future<void> writeSecureData(String key, String value) async {
    try {
      await secureStorage.write(
        key: key,
        value: value
      );
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
  bool _isLoading = true;

  final GlobalKey<SecurityFormWidgetState> _securityFormKey =
      GlobalKey<SecurityFormWidgetState>();
  
  Future<void> _initialize() async {
    await checkUserLoginStatus();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> checkUserLoginStatus() async {
    try {
      // Check if user is already authenticated
      final response = await corpApiService.getStatus();
      
      if (response.data['authentificated'] == true) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      // User is not authenticated, stay on login screen
      print('Not authenticated: $e');
    }
  }

  Future<void> _performLogin() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await corpApiService.login(
        username: handleController.text,
        password: _hashPassword(passwordController.text),
        otp: OTPController.text.isNotEmpty ? int.parse(OTPController.text) : null,
      );

      if (response.data['msg'] == 'logged_in') {
        final accessToken = response.data['corp_access_pass'] as String?;
        final refreshToken = response.data['corp_refresh_pass'] as String?;

        if (refreshToken != null) {
          await writeSecureData('corp_refresh_pass', refreshToken);
        } else {
          print("refresh token not found!");
        }

        if (accessToken != null) {
          await writeSecureData('corp_access_pass', accessToken);
        } else {
          print("access token not found!");
        }

        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Show error message
        _showErrorDialog('Login failed. Please check your credentials.');
      }
    } on DioException catch (e) {
      String errorMessage = 'Login failed. Please try again.';
      
      if (e.response?.statusCode == 400) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> && errorData.containsKey('msg')) {
          errorMessage = errorData['msg'] as String;
        }
      } else if (e.response?.statusCode == 401) {
        errorMessage = 'Invalid credentials. Please check your username and password.';
      }
      
      _showErrorDialog(errorMessage);
    } catch (e) {
      _showErrorDialog('An unexpected error occurred. Please try again.');
      print('Login error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
      backgroundColor: const Color(0xFF1E1E1E),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E1E), Color(0xFF2D2D2D)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            
            // Logo section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/corp_logo.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The Corporation',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Login form
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    SecurityFormWidget(
                      key: _securityFormKey,
                      formTitle: 'Login',
                      controller1: handleController,
                      controller2: passwordController,
                      controller3: OTPController,
                      textFieldTitle1: 'Handle',
                      textFieldTitle2: 'Password',
                      textFieldTitle3: 'OTP',
                      buttonTitle1: 'Login',
                      buttonTitle2: 'Forgot Password',
                      buttonTitle3: 'Register',
                      buttonAction1: _performLogin,
                      buttonAction2: () => print('Forgot password'),
                      buttonAction3: () => Navigator.pushReplacementNamed(context, '/register'),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Register link
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Don\'t have an account? Register here',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
