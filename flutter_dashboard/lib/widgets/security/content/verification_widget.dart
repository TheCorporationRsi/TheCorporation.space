import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_dashboard/widgets/security/security_module_widget.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class VerificationWidget extends StatefulWidget {
  final String formTitle;
  final String token;
  final String description;
  final String textFieldTitle1;
  final String buttonTitle1;
  final String buttonTitle2;
  final String buttonTitle3;
  final VoidCallback buttonAction1;
  final VoidCallback buttonAction2;
  final VoidCallback buttonAction3;

  const VerificationWidget({
    super.key,
    required this.formTitle,
    required this.token,
    required this.description,
    required this.textFieldTitle1,
    required this.buttonTitle1,
    required this.buttonTitle2,
    required this.buttonTitle3,
    required this.buttonAction1,
    required this.buttonAction2,
    required this.buttonAction3,
  });

  @override
  State<VerificationWidget> createState() => VerificationWidgetState();
}

class VerificationWidgetState extends State<VerificationWidget> {
  final GlobalKey<SecurityModuleWidgetState> _moduleKey =
      GlobalKey<SecurityModuleWidgetState>();

  void showError(String message) {
    setState(() {
      _moduleKey.currentState?.showError(message);
    });
  }

  void _copyToken() {
    Clipboard.setData(ClipboardData(text: widget.token));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            'Token copied to clipboard',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formfield = <Widget>[
      const SizedBox(height: 16.0),
      AutoSizeText(
        widget.description,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        textAlign: TextAlign.center, // Center align the text
        maxLines: 4,
      ),
      const SizedBox(height: 16.0),
      SelectionArea(
        child: AutoSizeText(
          widget.token,
          style: TextStyle(color: secondaryColor, fontSize: 20.0),
          maxLines: 1,
        ),
      ),

      const SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _copyToken,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          elevation: 10.0,
          shadowColor: Colors.black,
          overlayColor: Colors.grey,
        ),
        child: Text('Copy Token', style: TextStyle(color: Colors.white)),
      ),
      const SizedBox(height: 24.0),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.buttonAction1,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor, // Set background color to black
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold, // make text bold
            ), // text color and size
            padding: EdgeInsets.symmetric(
                horizontal: 32.0, vertical: 16.0), // button size
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // remove rounded corners
            ),
            elevation: 10.0, // Add elevation for 3D effect
            shadowColor: Colors.black, // Set shadow color
            overlayColor: Colors.grey, // Set color to grey on hover and click
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.buttonTitle1,
              style:
                  TextStyle(color: Colors.white), // ensure text color is white
            ),
          ),
        ),
      ),
      const SizedBox(height: 16.0), // Add spacing between button and links
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: widget.buttonAction2,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    backgroundColor, // Set background color to black
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold, // make text bold
                ), // text color and size
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0), // button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        10.0), // Add radius to bottom left corner
                  ),
                ),
                elevation: 10.0, // Add elevation for 3D effect
                shadowColor: Colors.black, // Set shadow color
                overlayColor:
                    Colors.grey, // Set color to grey on hover and click
              ),
              child: AutoSizeText(
                widget.buttonTitle2,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
                minFontSize: 10.0,
                maxFontSize: 15.0, // ensure text color is white
              ),
            ),
          ),
          const SizedBox(width: 16.0), // Add spacing between buttons
          Expanded(
            child: ElevatedButton(
              onPressed: widget.buttonAction3,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    backgroundColor, // Set background color to black
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold, // make text bold
                ), // text color and size
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0), // button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight:
                        Radius.circular(10.0), // Add radius to top right corner
                  ),
                ),
                elevation: 10.0, // Add elevation for 3D effect
                shadowColor: Colors.black, // Set shadow color
                overlayColor:
                    Colors.grey, // Set color to grey on hover and click
              ),
              child: AutoSizeText(
                widget.buttonTitle3,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
                minFontSize: 10.0,
                maxFontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    ];

    final desktop_form = Column(
      children: [
        Expanded(
          child: Row(
            children: <Widget>[
              Container(
                width: 400.0,
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 70.0, bottom: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: formfield),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                child: Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        20.0), // Add padding around the logo
                    child: Image.asset(
                      'assets/logo/corp_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final mobile_form = Column(
      children: [
        const SizedBox(height: 50.0), // Added padding on top of the form
        Image.asset(
          'assets/logo/corp_logo.png',
          fit: BoxFit.cover,
          height: 120.0, // Adjust the height to make the logo bigger
        ),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: formfield),
        ),
      ],
    );

    return SecurityModuleWidget(
      key: _moduleKey,
      formTitle: widget.formTitle,
      DesktoColumn: desktop_form,
      MobileColumn: mobile_form,
    );
  }
}
