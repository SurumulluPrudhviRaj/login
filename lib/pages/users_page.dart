import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/components/my_drawer.dart';
import 'package:login/components/my_list_tile.dart';
import 'package:login/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          // 🔴 Error handling
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong!", context);
            return const Center(child: Text("Error loading users."));
          }

          // 🔄 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🟡 Empty check
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Users Found"));
          }

          // ✅ Users available
          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userDoc = users[index];
              final userData = userDoc.data() as Map<String, dynamic>?;

              if (userData == null) return const SizedBox();

              final username = userData['username'] ?? 'Unknown';
              final email = userData['email'] ?? 'No email';

              // 🔁 OLD:
              /*
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(username),
                subtitle: Text(email),
              );
              */

              // ✅ NEW:
              return MyListTile(
                title: username,
                subtitle: email,
              );
            },
          );
        },
      ),
    );
  }
}
