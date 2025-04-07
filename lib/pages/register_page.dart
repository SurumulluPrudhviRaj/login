import 'package:flutter/material.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/my_button.dart';
import 'package:login/helper/helper_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  // Text controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpwdController = TextEditingController();

  RegisterPage({super.key, required this.onTap});
  void register(BuildContext context) async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    final username = userNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmpwdController.text;

    if (password != confirmPassword) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show error message
      displayMessageToUser("Passwords Don't Match", context);
      return; // Exit early if passwords don't match
    } else {
      try {
        // Attempt to create a user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        // Show success message or navigate to another page if needed
        print('User registered successfully: ${userCredential.user?.email}');
        Navigator.pop(context); // Close the loading dialog
        displayMessageToUser("Registration Successful", context);

        // Optionally, navigate to another screen or perform further actions
      } catch (e) {
        // Handle any errors during user creation (e.g., weak password, invalid email)
        Navigator.pop(context); // Close the loading dialog
        displayMessageToUser("Registration Failed: ${e.toString()}", context);
      }
    }
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 40),

              // Username
              MyTextfield(
                hintText: "User Name",
                obscureText: false,
                controller: widget.userNameController,
              ),
              const SizedBox(height: 20),

              // Email
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: widget.emailController,
              ),
              const SizedBox(height: 20),

              // Password
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: widget.passwordController,
              ),
              const SizedBox(height: 20),

              // Confirm Password
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: widget.confirmpwdController,
              ),
              const SizedBox(height: 30),

              // Register Button
              MyButton(text: "Register", onTap: () => widget.register(context)),
              const SizedBox(height: 20),

              // Navigate to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.onTap, // ✅ Using passed function
                    child: const Text(
                      "Login Here",
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
