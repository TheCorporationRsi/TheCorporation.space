import 'package:flutter/material.dart';
import 'package:flutter_dashboard/widgets/security/content/security_form_widget.dart'; // Ensure this path is correct
import 'package:url_launcher/url_launcher.dart';

import 'package:corp_api/corp_api.dart';
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
          buttonAction1: () {
            final RegisterRequest registerRequest = RegisterRequest((b) => b
              ..username = handleController.text
              ..password = passwordController.text
              ..confirmedPassword = confirmPasswordController.text);

            var corpSecurityClient = CorpApi().getSecurityApi();

            corpSecurityClient
                .register(registerRequest: registerRequest)
                .then((response) async {
              print(response);

              if (response.data!.msg == 'User created') {
                Navigator.pushNamed(context, '/login');
              } else {
                _securityFormKey.currentState?.showError("User not created, try again later");
              }
            }).catchError((error) {
              if (error.response.statusCode == 400) {
                _securityFormKey.currentState
                    ?.showError(jsonDecode(error.response.toString())['msg']);
              } else {
                print(error);
              }
            });
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
