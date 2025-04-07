import 'package:flutter/material.dart';
import 'package:login/components/my_drawer.dart'; // Optional: if you want the drawer here too

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const MyDrawer(), // optional
      body: const Center(
        child: Text(
          "This is the Users Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
