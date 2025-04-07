import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/components/my_drawer.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/my_postbutton.dart';
import 'package:login/components/my_list_tile.dart';
import 'package:login/database/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  @override
  void dispose() {
    newPostController.dispose();
    super.dispose();
  }

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      final message = newPostController.text.trim();
      database.addPost(message);
      newPostController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 🔹 Input Row
            Row(
              children: [
                Expanded(
                  child: MyTextfield(
                    hintText: "Say something..",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 55,
                  width: 55,
                  child: PostButton(onTap: postMessage),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔥 Posts Stream
            Expanded(
              child: StreamBuilder(
                stream: database.getPostsStream(),
                builder: (context, snapshot) {
                  // 🔄 Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ❌ Error state
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  // ✅ Post data
                  final posts = snapshot.data?.docs ?? [];

                  if (posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text("No posts... Post something!"),
                      ),
                    );
                  }

                  // 📋 Return posts using custom MyListTile
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final data = post.data() as Map<String, dynamic>;

                      String message = data['PostMessage'] ?? 'No message';
                      String userEmail = data['UserEmail'] ?? 'Unknown';
                      // You can use the timestamp for sorting or displaying
                      // Timestamp timestamp = data['TimeStamp'] ?? Timestamp.now();

                      return MyListTile(
                        title: message,
                        subtitle: userEmail,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
