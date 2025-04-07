import 'package:firebase_auth/firebase_auth.dart';  // Firebase import
import 'package:flutter/material.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/my_button.dart'; // assuming you have MyButton as a separate widget

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key, this.onTap});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Login method with Firebase authentication
  void login() async {
    final email = widget.emailController.text.trim();
    final password = widget.passwordController.text.trim();

    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // Authenticate with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Close loading dialog
      Navigator.pop(context);

      // Check if login is successful
      if (userCredential.user != null) {
        print('Logged in as: ${userCredential.user?.email}');
        // Navigate to the next screen or show a success message
      }
    } catch (e) {
      // Close loading dialog if login fails
      Navigator.pop(context);

      // Show error message if login fails
      displayMessageToUser("Login Failed: ${e.toString()}", context);
    }
  }

  // Display a message to the user
  void displayMessageToUser(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              // Title
              Text(
                'S O C I A L',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 50),

              // Email
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: widget.emailController,
              ),
              const SizedBox(height: 10),

              // Password
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: widget.passwordController,
              ),
              const SizedBox(height: 20),

              // Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Forgot password logic here
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Login Button
              MyButton(text: "Log In", onTap: login),
              const SizedBox(height: 20),

              // Navigate to Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: widget.onTap, // Callback to switch page
                    child: const Text(
                      "Register Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
