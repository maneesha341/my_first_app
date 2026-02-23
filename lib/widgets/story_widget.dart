import 'dart:io';
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../screens/story_view_screen.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({super.key});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {

  final List<String> usernames = [
    "riya",
    "ananya",
    "rahul",
    "kiran",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppData.stories.length + usernames.length,
        itemBuilder: (context, index) {

          /// 🔥 YOUR STORIES FIRST
          if (index < AppData.stories.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoryViewScreen(index: index),
                    ),
                  );
                },
                child: Column(
                  children: [

                    // 🔥 Instagram Gradient Ring
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFF58529),
                            Color(0xFFDD2A7B),
                            Color(0xFF8134AF),
                          ],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage:
                              FileImage(AppData.stories[index]),
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),
                    const Text(
                      "Your Story",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          }

          /// 🔥 DEFAULT USERS
          int userIndex = index - AppData.stories.length;

          // 🛑 SAFETY CHECK
          if (userIndex >= usernames.length) {
            return const SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryViewScreen(index: userIndex),
                  ),
                );
              },
              child: Column(
                children: [

                  // 🔥 Gradient Border
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF58529),
                          Color(0xFFDD2A7B),
                          Color(0xFF8134AF),
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?img=${userIndex + 1}",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    usernames[userIndex],
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}