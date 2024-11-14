import 'package:flutter/material.dart';
import 'package:flutter_dashboard/widgets/security/security_form_widget.dart'; // Ensure this path is correct


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController handleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController OTPController = TextEditingController();

  final GlobalKey<SecurityFormWidgetState> _securityFormKey = GlobalKey<SecurityFormWidgetState>();

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
        formTitle: 'LOGIN',
        controller1: handleController,
        controller2: passwordController,
        controller3: OTPController,
        textFieldTitle1: 'RSI handle',
        textFieldTitle2: 'Password',
        textFieldTitle3: 'OTP (optional)',
        buttonTitle1: 'Login',
        buttonTitle2: 'Register',
        buttonTitle3: 'Forgot Password?',
        buttonAction1: () {
          if (handleController.text == 'test' && passwordController.text == 'test') {
            // Proceed with login
            Navigator.pushNamed(context, '/verification');
          } else {
            // Show error message
            _securityFormKey.currentState?.showError('This is not an error message');
      
          }
        },
        buttonAction2: () {
          Navigator.pushNamed(context, '/register');
        },
        buttonAction3: () {
          // Handle forgot password action
        },
      ),
        ],
    ));
  }
}
