import 'package:flutter/material.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      // Removed the AppBar
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_background.jpg'), // Set your background image here
                fit: BoxFit.cover,
                alignment: Alignment.centerRight, // Start the background image from the right
              ),
            ),
          ),
          // Foreground content
          Center(
            child: isDesktop
                ? Stack(
                    children: [
                      // Title container under the ClipPath
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ClipPath(
                          clipper: TitleClipperDesktop(),
                          child: Container(
                            width: 385.0, // Half the length of the container
                            height: 0.15* 420 -10, // 15% of the height of the container (420.0 * 0.15)
                            color: primaryColor, // Set the background color
                            child: Center( // Center the text
                              child: Text(
                                'REGISTER',
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
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 400.0,
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 50.0), // Added padding on top of the form
                                      TextField(
                                        decoration: const InputDecoration(
                                          labelText: 'RSI handle',
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
                                          labelText: 'Confirm Password',
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
                                      const SizedBox(height: 32.0), // Increased margin
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Handle registration logic here
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
                                              'Register',
                                              style: TextStyle(color: Colors.white), // ensure text color is white
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
                                              onPressed: () {
                                                Navigator.pushNamed(context, '/login'); // Navigate to login page
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: backgroundColor, // Set background color to black
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold, // make text bold
                                                ), // text color and size
                                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // button size
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0), // Add radius to bottom left corner
                                                  ),
                                                ),
                                                elevation: 10.0, // Add elevation for 3D effect
                                                shadowColor: Colors.black, // Set shadow color
                                                overlayColor: Colors.grey, // Set color to grey on hover and click
                                              ),
                                              child: Text(
                                                'Login',
                                                style: TextStyle(color: Colors.white), // ensure text color is white
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16.0), // Add spacing between buttons
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Navigate to reset password page
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: backgroundColor, // Set background color to black
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold, // make text bold
                                                ), // text color and size
                                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // button size
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(10.0), // Add radius to top right corner
                                                  ),
                                                ),
                                                elevation: 10.0, // Add elevation for 3D effect
                                                shadowColor: Colors.black, // Set shadow color
                                                overlayColor: Colors.grey, // Set color to grey on hover and click
                                              ),
                                              child: Text(
                                                'Need help?',
                                                style: TextStyle(color: Colors.white), // ensure text color is white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                  ),
                                  child: Container(
                                      width: 400.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0), // Add padding around the logo
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
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      // Title container under the ClipPath
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ClipPath(
                          clipper: TitleClipperMobile(),
                          child: Container(
                            width: 0.7 * 300 - 10, // Adjust the width as needed
                            height: 0.1 * 520.0 - 8, // Adjust the height as needed
                            color: primaryColor, // Set the background color
                            child: Align( // Align the text to the left
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0), // Add padding to the left
                                child: Text(
                                  'REGISTER',
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(height: 50.0), // Added padding on top of the form
                                Image.asset(
                                  'assets/logo/corp_logo.png',
                                  fit: BoxFit.cover,
                                  height: 120.0, // Adjust the height to make the logo bigger
                                ),

                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'RSI handle',
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
                                    labelText: 'Confirm Password',
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
                                const SizedBox(height: 32.0), // Increased margin
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle registration logic here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: backgroundColor, // Set background color to black
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
                                        'Register',
                                        style: TextStyle(color: Colors.white), // ensure text color is white
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
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/login'); // Navigate to login page
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: backgroundColor, // Set background color to black
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold, // make text bold
                                          ), // text color and size
                                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // button size
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0), // Add radius to bottom left corner
                                            ),
                                          ),
                                          elevation: 10.0, // Add elevation for 3D effect
                                          shadowColor: Colors.black, // Set shadow color
                                          overlayColor: Colors.grey, // Set color to grey on hover and click
                                        ),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white), // ensure text color is white
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0), // Add spacing between buttons
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to reset password page
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: backgroundColor, // Set background color to black
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold, // make text bold
                                          ), // text color and size
                                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // button size
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10.0), // Add radius to top right corner
                                            ),
                                          ),
                                          elevation: 10.0, // Add elevation for 3D effect
                                          shadowColor: Colors.black, // Set shadow color
                                          overlayColor: Colors.grey, // Set color to grey on hover and click
                                        ),
                                        child: Text(
                                          'Need help?',
                                          style: TextStyle(color: Colors.white), // ensure text color is white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
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
    path.lineTo(size.width, size.height *0.8);
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
    path.moveTo(size.height * 0.10, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.10); // Add a curve to the top left corner
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
    path.moveTo(size.height * 0.2, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.2); // Add a curve to the top left corner
    path.lineTo(0, size.height);
    path.lineTo(size.width - size.height, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}