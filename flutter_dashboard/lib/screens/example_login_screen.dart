import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/services/service_locator.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

/// Example of how to update login functionality to use the dynamic API client
/// This shows the key changes needed when migrating from the generated client

class ExampleLoginScreen extends StatefulWidget {
  const ExampleLoginScreen({super.key});

  @override
  _ExampleLoginScreenState createState() => _ExampleLoginScreenState();
}

class _ExampleLoginScreenState extends State<ExampleLoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool _isLoading = false;

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Example of login using the new dynamic API client
  Future<void> _performLogin() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      _showErrorDialog('Please enter username and password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // OLD WAY (using generated client):
      // final LoginRequest loginRequest = LoginRequest((b) => b
      //   ..username = usernameController.text
      //   ..password = _hashPassword(passwordController.text)
      //   ..otp = otp);
      // var corpSecurityClient = CorpApi().getSecurityApi();
      // final response = await corpSecurityClient.login(loginRequest: loginRequest);

      // NEW WAY (using dynamic client):
      final response = await corpApiService.login(
        username: usernameController.text,
        password: _hashPassword(passwordController.text),
        otp: otpController.text.isNotEmpty ? int.parse(otpController.text) : null,
      );

      // Handle response
      // OLD WAY: response.data!.msg
      // NEW WAY: response.data['msg']
      if (response.data['msg'] == 'logged_in') {
        // OLD WAY: response.data!.corpAccessPass
        // NEW WAY: response.data['corp_access_pass']
        final accessToken = response.data['corp_access_pass'] as String?;
        final refreshToken = response.data['corp_refresh_pass'] as String?;

        if (refreshToken != null) {
          await secureStorage.write(key: 'corp_refresh_pass', value: refreshToken);
        }

        if (accessToken != null) {
          await secureStorage.write(key: 'corp_access_pass', value: accessToken);
        }

        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
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
        errorMessage = 'Invalid credentials.';
      }
      
      _showErrorDialog(errorMessage);
    } catch (e) {
      _showErrorDialog('An unexpected error occurred.');
      print('Login error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Example of checking authentication status
  Future<void> _checkLoginStatus() async {
    try {
      // OLD WAY: CorpApi().getSecurityApi().getStatus()
      // NEW WAY: corpApiService.getStatus()
      final response = await corpApiService.getStatus();
      
      if (response.data['authentificated'] == true) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      print('Not authenticated: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Example'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Dynamic API Client Login Example',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: _isLoading ? null : _performLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login', style: TextStyle(fontSize: 16)),
            ),
            
            const SizedBox(height: 16),
            
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Don\'t have an account? Register'),
            ),
            
            const SizedBox(height: 32),
            
            // API Information Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'API Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Base URL: ${corpApiService.isReady ? "Connected" : "Not Connected"}'),
                    const SizedBox(height: 16),
                    
                    ElevatedButton(
                      onPressed: _showEndpointInfo,
                      child: const Text('Show Available Endpoints'),
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

  void _showEndpointInfo() {
    final dynamicClient = ServiceLocator().dynamicApiClient;
    final endpoints = dynamicClient.endpoints;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Available Endpoints'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: ListView.builder(
            itemCount: endpoints?.length ?? 0,
            itemBuilder: (context, index) {
              final entry = endpoints!.entries.elementAt(index);
              final endpoint = entry.value;
              
              return ListTile(
                title: Text(endpoint.operationId),
                subtitle: Text('${endpoint.method.toUpperCase()} ${endpoint.path}'),
                dense: true,
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
