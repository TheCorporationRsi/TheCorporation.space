import 'package:flutter/material.dart';
import 'package:flutter_dashboard/widgets/security/content/security_form_widget.dart'; // Ensure this path is correct
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto/crypto.dart'; // Add this import for hashing

import 'package:flutter_dashboard/services/service_locator.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController handleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = true;

  final GlobalKey<SecurityFormWidgetState> _securityFormKey =
      GlobalKey<SecurityFormWidgetState>();

  Future<void> _initialize() async {
    await checkSecurityLevel(context, 'NotLoggedIn'); // Ensure this completes before setting loading to false
    setState(() {
      _isLoading = false;
    });
  }

  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var digest = sha256.convert(bytes); // Hash the password using SHA-256
    return digest.toString(); // Convert the hash to a string
  }

  @override
  void initState() {
    super.initState();
    _initialize(); // Call _initialize after super.initState()
    // Your initialization code here
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        body: Stack(
      children: [
        // Background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/login_background.jpg'), // Set your background image here
              fit: BoxFit.cover,
              alignment: Alignment
                  .centerRight, // Start the background image from the right
            ),
          ),
        ),
        // Foreground content
        SecurityFormWidget(
          key: _securityFormKey,
          formTitle: 'REGISTER',
          controller1: handleController,
          controller2: passwordController,
          controller3: confirmPasswordController,
          textFieldTitle1: 'RSI handle',
          textFieldTitle2: 'Password',
          textFieldTitle3: 'Confirm Password',
          autofillHints1: [AutofillHints.username],
          autofillHints2: [AutofillHints.password],
          buttonTitle1: 'Register',
          buttonTitle2: 'Login',
          buttonTitle3: 'Need Help?',
          buttonAction1: () async {
            try {
              final apiService = ServiceLocator().corpApiService;
              await apiService.register(
                username: handleController.text,
                password: _hashPassword(passwordController.text),
                confirmedPassword: _hashPassword(confirmPasswordController.text),
              );
              
              Navigator.pushNamed(context, '/login');
            } catch (error) {
              print(error);
              if (error.toString().contains('400')) {
                _securityFormKey.currentState
                    ?.showError("Registration failed - please check your input");
              } else {
                _securityFormKey.currentState?.showError("User not created, try again later");
              }
            }
          },
          buttonAction2: () {
            Navigator.pushNamed(context, '/login');
          },
          buttonAction3: () {
            launchUrl(Uri.parse('https://discord.gg/thecorporation'));
          },
        ),
      ],
    ));
  }
}
