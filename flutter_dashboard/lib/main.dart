import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/screens/dashboard.dart';
import 'package:flutter_dashboard/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CORP Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
