import 'package:flutter/material.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class SecurityModuleWidget extends StatefulWidget {
  final Column DesktoColumn;
  final Column MobileColumn;
  final String formTitle;

  const SecurityModuleWidget({
    super.key,
    required this.formTitle,
    required this.DesktoColumn,
    required this.MobileColumn,
  });

  @override
  State<SecurityModuleWidget> createState() => SecurityModuleWidgetState();
}

class SecurityModuleWidgetState extends State<SecurityModuleWidget> {
  double _errorBannerPosition = -51;
  String _errorMessage = '';

  void showError(String message) {
    setState(() {
      _errorMessage = message;
      _errorBannerPosition = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Center(
      child: isDesktop
          ? Container(
              height: 470.0, // Specify the height here
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: 420 + _errorBannerPosition,
                    left: 800 * 0.3 / 2,
                    right: 800 * 0.3 / 2,
                    child: Center(
                      child: ClipPath(
                        clipper: ErrorBannerClipper(),
                        child: Container(
                          width: 800 * 0.7,
                          height: 50.0,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              _errorMessage,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Title container under the ClipPath
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ClipPath(
                      clipper: TitleClipperDesktop(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                        child: Container(
                          width: 385.0, // Half the length of the container
                          height: 0.15 * 420 - 10, // 15% of the height of the container (420.0 * 0.15)
                          color: primaryColor, // Set the background color
                          child: Center(
                            // Center the text
                            child: Text(
                              widget.formTitle,
                              style: GoogleFonts.orbitron(
                                textStyle: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 28.0, // Make the text bigger
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: FuturisticClipperDesktop(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        width: 800.0,
                        height: 420.0,
                        decoration: BoxDecoration(
                          color: cardBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: widget.DesktoColumn,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 545.0, // Specify the height here
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: 520 + _errorBannerPosition / 2,
                    left: 300 * 0.1 / 2,
                    right: 300 * 0.1 / 2,
                    child: Center(
                      child: ClipPath(
                        clipper: ErrorBannerClipper(),
                        child: Container(
                          width: 300 * 0.9,
                          height: 25,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              'Invalid credentials, please try again.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Title container under the ClipPath
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ClipPath(
                      clipper: TitleClipperMobile(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                        child: Container(
                          width: 0.7 * 300 - 10, // Adjust the width as needed
                          height: 0.1 * 520.0 - 8, // Adjust the height as needed
                          color: primaryColor, // Set the background color
                          child: Align(
                            // Align the text to the left
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50.0), // Add padding to the left
                              child: Text(
                                widget.formTitle,
                                style: GoogleFonts.orbitron(
                                  textStyle: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 22.0, // Make the text bigger
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: FuturisticClipperMobile(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: 300.0,
                        height: 520.0, // Increased height to fit the login button
                        padding: const EdgeInsets.all(16.0), // Reduced padding around the logo
                        decoration: BoxDecoration(
                          color: cardBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: widget.MobileColumn,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class FuturisticClipperDesktop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.15);
    path.lineTo(size.width * 0.5 - size.height * 0.15, size.height * 0.15);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width - size.height * 0.2, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TitleClipperDesktop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width - size.height, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class FuturisticClipperMobile extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.1);
    path.lineTo(size.width * 0.7 - size.height * 0.1, size.height * 0.1);
    path.lineTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TitleClipperMobile extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width - size.height, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ErrorBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - size.height, size.height);
    path.lineTo(size.height, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
