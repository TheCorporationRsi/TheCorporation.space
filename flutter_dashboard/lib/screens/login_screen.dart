import 'package:flutter/material.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'dart:ui';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          // Removed the background image
          // image: DecorationImage(
          //   image: AssetImage('assets/images/login_background.jpg'),
          //   fit: BoxFit.cover,
          //   alignment: Alignment.centerRight,
          // ),
        ),
        child: Center(
          child: isDesktop
              ? Stack(
                  children: [
                    // Title container under the ClipPath
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ClipPath(
                        clipper: TitleClipper(),
                        child: Container(
                          width: 388.0, // Half the length of the container
                          height: 50.0, // 15% of the height of the container (400.0 * 0.15)
                          color: primaryColor, // Set the background color
                          child: Center( // Center the text
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 28.0, // Make the text bigger
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto', // Change font to Roboto
                                ),
                              ),
                           
                          ),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: FuturisticClipper(),
                      child: Container(
                        width: 800.0,
                        height: 400.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: cardBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 50.0), // Added padding on top of the form
                                  TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.yellow), // Change border color to yellow on focus
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.yellow), // Change border color to yellow on focus
                                      ),
                                    ),
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'OTP (optional)',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.yellow), // Change border color to yellow on focus
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 32.0), // Increased margin
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle login logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: backgroundColor , // Set background color to black
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold, // make text bold
                                        ), // text color and size
                                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // button size
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero, // remove rounded corners
                                        ),
                                        elevation: 10.0, // Add elevation for 3D effect
                                        shadowColor: Colors.black, // Set shadow color
                                        overlayColor: Colors.grey, // Set color to grey on hover and click
                                      ),
                                      child: const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white), // ensure text color is white
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.0),
                                bottomRight: Radius.circular(16.0),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                                child: Container(
                                  width: 400.0,
                                  decoration: BoxDecoration(
                                    color: cardBackgroundColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.0),
                                      bottomRight: Radius.circular(16.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0), // Add padding around the logo
                                    child: Image.asset(
                                      'assets/logo/corp_logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  width: 300.0,
                  height: 450.0, // Increased height to fit the login button
                  padding: const EdgeInsets.all(16.0), // Reduced padding around the logo
                  decoration: BoxDecoration(
                    color: cardBackgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 50.0), // Added padding on top of the form
                      Image.asset(
                        'assets/logo/corp_logo.png',
                        fit: BoxFit.cover,
                        height: 80.0, // Adjust the height as needed
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow), // Change border color to yellow on focus
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow), // Change border color to yellow on focus
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'One-Time Code',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow), // Change border color to yellow on focus
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 32.0), // Increased margin
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle login logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Set background color to black
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold, // make text bold
                            ), // text color and size
                            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // button size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // remove rounded corners
                            ),
                            elevation: 10.0, // Add elevation for 3D effect
                            shadowColor: Colors.black, // Set shadow color
                            overlayColor: Colors.grey, // Set color to grey on hover and click
                          ),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white), // ensure text color is white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class FuturisticClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.15);
    path.lineTo(size.width * 0.5 - size.height * 0.15, size.height * 0.15);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height *0.8);
    path.lineTo(size.width - size.height * 0.2, size.height);
     path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TitleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width - size.height , size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}