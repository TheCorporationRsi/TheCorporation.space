import 'package:flutter/material.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dashboard/widgets/security/security_form_widget.dart'; // Ensure this path is correct
import 'dart:ui';

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

  final GlobalKey<SecurityFormWidgetState> _securityFormKey =
      GlobalKey<SecurityFormWidgetState>();

  @override
  Widget build(BuildContext context) {
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
          buttonTitle1: 'Register',
          buttonTitle2: 'Login',
          buttonTitle3: 'Need Help?',
          buttonAction1: () {
            if (handleController.text == 'test' &&
                passwordController.text == 'test' &&
                confirmPasswordController.text == 'test') {
              // Proceed with registration
              _securityFormKey.currentState
                  ?.showError('This is an error message');
            } else {
              // Show error message
              _securityFormKey.currentState
                  ?.showError('This is not an error message');
            }
          },
          buttonAction2: () {
            Navigator.pushNamed(context, '/login');
          },
          buttonAction3: () {
            // Handle forgot password action
          },
        ),
      ],
    ));
  }
}
