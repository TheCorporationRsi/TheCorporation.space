import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widgets/security/content/security_form_widget.dart'; // Ensure this path is correct
import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'dart:convert';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController handleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController OTPController = TextEditingController();

  final GlobalKey<SecurityFormWidgetState> _securityFormKey =
      GlobalKey<SecurityFormWidgetState>();

  @override
  void initState() {
    super.initState();
    // Your initialization code here
      checkSecurityLevel(context, 'NotLoggedIn');
  }

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
          autofillHints1: [AutofillHints.username],
          autofillHints2: [AutofillHints.password],
          buttonTitle1: 'Login',
          buttonTitle2: 'Register',
          buttonTitle3: 'Forgot Password?',
          buttonAction1: () {

            

            final otp = OTPController.text.isEmpty
                ? null
                : int.parse(OTPController.text);

            

            final LoginRequest loginRequest = LoginRequest((b) => b
              ..username = handleController.text
              ..password = passwordController.text
              ..otp = otp);

            var corpSecurityClient = CorpApi().getSecurityApi();

            

            corpSecurityClient.login(loginRequest: loginRequest)
              .then((response) {
                
                print(response);
                
                if (response.data!.msg == 'logged_in')
                  {
                    final accessToken = response.data!.corpAccessPass;
                    final refreshToken = response.data!.corpRefreshPass;

                    secureStorage.write(
                      key: 'accessToken',
                      value: accessToken,
                    );

                    secureStorage.write(
                      key: 'refreshToken',
                      value: refreshToken,
                    );

                    checkSecurityLevel(context, 'rsiVerified');
                    Navigator.pushNamed(context, '/dashboard');

                    }
                    else {
                      print("Cookies were not set");
                    }
                
                  
              })
              .catchError((error) {
                
                if ( error.response.statusCode == 400){
                  _securityFormKey.currentState?.showError(jsonDecode(error.response.toString())['msg']);
                }
                else {
                  print(error);
                }
                
              });
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
