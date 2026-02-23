import 'package:flutter/material.dart';

class StoryViewScreen extends StatelessWidget {
  final int index;

  StoryViewScreen({super.key, required this.index});

  final List<String> usernames = [
    "maneesha",
    "riya",
    "ananya",
    "rahul",
    "kiran",
    "sneha",
    "arjun",
    "divya",
    "vishal",
    "neha",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://picsum.photos/500/900?random=${index + 1}",
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=${index + 1}",
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  usernames[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}