import 'package:flutter/material.dart';
import 'package:login/theme/dark_mode.dart';
import 'package:login/theme/light_mode.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: LoginPage(), 
      theme: lightMode,// Login page as the home screen
      darkTheme: darkMode,
    );
  }
}
