import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/auth/auth.dart';
import 'package:login/auth/login_or_register.dart'; // ✅ FIXED
import 'package:login/firebase_options.dart';
import 'package:login/pages/home_page.dart';
import 'package:login/pages/profile_page.dart';
import 'package:login/pages/users_page.dart';
import 'package:login/theme/dark_mode.dart';
import 'package:login/theme/light_mode.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(), // ✅ Use the toggle-enabled widget
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => const ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },

      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
