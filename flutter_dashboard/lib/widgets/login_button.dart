
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Text(
        'Login',
        style: TextStyle(
          color: Colors.white, // Changed text color to white
        ),
      ),
    );
  }
}