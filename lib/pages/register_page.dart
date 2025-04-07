// register_page.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/my_button.dart';
import 'package:login/helper/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpwdController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpwdController.dispose();
    super.dispose();
  }

void register() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  final username = userNameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text;
  final confirmPassword = confirmpwdController.text;

  if (password != confirmPassword) {
    Navigator.pop(context);
    displayMessageToUser("Passwords don't match", context);
    return;
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await createUserDocument(userCredential, username);

    if (context.mounted) Navigator.pop(context); // ✅ closes loader
    displayMessageToUser("Registration Successful", context);
  } catch (e) {
    if (context.mounted) Navigator.pop(context); // ✅ closes loader
    displayMessageToUser("Registration Failed: ${e.toString()}", context);
  }
}

  Future<void> createUserDocument(
    UserCredential userCredential,
    String username,
  ) async {
    final user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

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
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),
              Text(
                'S O C I A L',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              MyTextfield(
                hintText: "User Name",
                obscureText: false,
                controller: userNameController,
              ),
              const SizedBox(height: 20),
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmpwdController,
              ),
              const SizedBox(height: 30),
              MyButton(text: "Register", onTap: register),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
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
