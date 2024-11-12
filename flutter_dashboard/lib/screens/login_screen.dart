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
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: isDesktop
              ? Container(
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
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'OTP (optional)',
                                labelStyle: TextStyle(color: Colors.white),
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
                                  backgroundColor: primaryColor, // background color
                                  textStyle: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold, // make text bold
                                  ), // text color and size
                                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // button size
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero, // remove rounded corners
                                  ),
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('Login'),
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
                )
              : Container(
                  width: 300.0,
                  height: 300.0,
                  padding: const EdgeInsets.all(20.0),
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
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'One-Time Code',
                          labelStyle: TextStyle(color: Colors.white),
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
                            backgroundColor: primaryColor, // background color
                            textStyle: TextStyle(
                              color: secondaryColor,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold, // make text bold
                            ), // text color and size
                            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // button size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // remove rounded corners
                            ),
                          ),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Login'),
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