import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widgets/security/content/security_form_widget.dart'; // Ensure this path is correct
import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // Add this import for hashing

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
    var bytes = utf8.encode(password); // Convert password to bytes
    var digest = sha256.convert(bytes); // Hash the password using SHA-256
    return digest.toString(); // Convert the hash to a string
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
  bool _isLoading = true; // Ensure loading state is true initially

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)  {

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
              ..password = _hashPassword(passwordController.text)
              ..otp = otp);

            var corpSecurityClient = CorpApi().getSecurityApi();

            corpSecurityClient.login(loginRequest: loginRequest)
              .then((response) async {
                
                //print(response);
                
                if (response.data!.msg == 'logged_in')
                  {
                    final accessToken = response.data!.corpAccessPass;
                    final refreshToken = response.data!.corpRefreshPass;

                    if (refreshToken != null) {
                      await writeSecureData( 'corp_refresh_pass', refreshToken);
                    }
                    else {
                      print("refresh token not found!");
                    }

                    if (accessToken != null) {
                      await writeSecureData( 'corp_access_pass', accessToken);
                    }
                    else {
                      print("access token not found!");
                    }

                    Navigator.pushReplacementNamed(context, '/dashboard');
                    

                    }
                    else {
                      _securityFormKey.currentState?.showError("Login error, try again later");
                    }
                
                  
              }).catchError((error) {
                
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
