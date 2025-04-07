import 'package:flutter/material.dart';
import 'package:login/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text("Welcome to the Home Page!"),
      ),
    );
  }
}
