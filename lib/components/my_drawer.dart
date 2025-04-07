import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/auth/auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // 🔝 Drawer Header - NOT part of Column group
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "MENU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 📦 Grouped Menu Items
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text("H O M E"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/home_page');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text("P R O F I L E"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile_page');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.group,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text("U S E R S"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/users_page');
                    },
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // 🚪 Logout - Bottom section
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("L O G O U T"),
              onTap: () => logout(context),
            ),
          ),
        ],
      ),
    );
  }
}
