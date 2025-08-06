import 'package:flutter/material.dart';
import 'package:flutter_dashboard/widgets/security/content/verification_widget.dart'; // Ensure this path is correct
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'package:flutter_dashboard/services/service_locator.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  String verification_token = "a8Fj3kL9zQw2Xy7Ba8Fj3kL9zQw2Xy7B";

  final GlobalKey<VerificationWidgetState> _verificationKey =
      GlobalKey<VerificationWidgetState>();

  Future<void> getRsiToken() async {
    try {
      final apiService = ServiceLocator().corpApiService;
      final response = await apiService.getRSIToken();
      
      final tokenData = response.data as Map<String, dynamic>;
      final rsiToken = tokenData['RSI_token'];
      
      if (rsiToken != null) {
        setState(() {
          verification_token = rsiToken;
        });
      }
    }
    catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    // Your initialization code here
    checkSecurityLevel(context, 'authentificated');
    getRsiToken();
    
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
        VerificationWidget(
          key: _verificationKey,
          formTitle: 'VERIFICATION',
          description: '''In order to verify your Star Citizen account,

Please enter the verification token in your RSI profile bio:''',
          token: verification_token,
          textFieldTitle1: 'RSI handle',
          buttonTitle1: 'Verify',
          buttonTitle2: 'RSI profile',
          buttonTitle3: 'Need Help?',
          buttonAction1: () async {
            try {
              final apiService = ServiceLocator().corpApiService;
              await apiService.verifyRSIToken();
              Navigator.pushNamed(context, '/dashboard');
            }
            catch (error) {
              if (error is DioException && error.response?.statusCode == 400) {
                _verificationKey.currentState
                    ?.showError(jsonDecode(error.response.toString())['msg']);
              } else {
                print(error);
              }
            }
          },
          buttonAction2: () async {
            launchUrl(Uri.parse(
                'https://robertsspaceindustries.com/account/profile'));
          },
          buttonAction3: () {
            launchUrl(Uri.parse('https://discord.gg/thecorporation'));
          },
        ),
      ],
    ));
  }
}
