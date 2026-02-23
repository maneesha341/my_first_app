import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String profileImage;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          // 🔥 Profile Photo
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileImage),
          ),

          const SizedBox(height: 15),

          // 🔥 Username
          Text(
            username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Welcome to my profile ✨",
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 25),

          // 🔥 Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Column(
                children: [
                  Text("12",
                      style:
                          TextStyle(fontWeight: FontWeight.bold)),
                  Text("Posts"),
                ],
              ),
              Column(
                children: [
                  Text("540",
                      style:
                          TextStyle(fontWeight: FontWeight.bold)),
                  Text("Followers"),
                ],
              ),
              Column(
                children: [
                  Text("320",
                      style:
                          TextStyle(fontWeight: FontWeight.bold)),
                  Text("Following"),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 🔥 Grid Posts
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return Image.network(
                  "https://picsum.photos/200?random=$index",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}