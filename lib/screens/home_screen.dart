import 'dart:io';
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/story_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> usernames = [
    "meghana",
    "riya",
    "ananya",
    "rahul",
    "kiran",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 15),
          Icon(Icons.send_outlined, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),

      body: ListView(
        children: [

          /// 🔥 STORIES
          StoryWidget(),
          const Divider(height: 1),

          /// 🔥 USER CREATED POSTS
          ...List.generate(AppData.posts.length, (index) {
            var post = AppData.posts[index];
            return buildUserPost(post);
          }),

          /// 🔥 DEFAULT POSTS
          buildDummyPost(0),
          buildDummyPost(1),
        ],
      ),
    );
  }

  // ===============================
  // USER POST WITH LIKE
  // ===============================
  Widget buildUserPost(Map post) {

    bool isLiked = false;
    int likeCount = 0;

    return StatefulBuilder(
      builder: (context, setPostState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              title: const Text(
                "meghana",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.more_vert),
            ),

            Image.file(
              post["image"],
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            /// 🔥 ACTION ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [

                  GestureDetector(
                    onTap: () {
                      setPostState(() {
                        isLiked = !isLiked;
                        likeCount += isLiked ? 1 : -1;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                  ),

                  const SizedBox(width: 15),
                  const Icon(Icons.mode_comment_outlined),
                  const SizedBox(width: 15),
                  const Icon(Icons.send_outlined),
                  const Spacer(),
                  const Icon(Icons.bookmark_border),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "$likeCount likes",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(post["caption"]),
            ),

            const SizedBox(height: 15),
            const Divider(),
          ],
        );
      },
    );
  }

  // ===============================
  // DEFAULT POSTS
  // ===============================
  Widget buildDummyPost(int index) {

    bool isLiked = false;
    int likeCount = 120;

    return StatefulBuilder(
      builder: (context, setPostState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=${index + 3}",
                ),
              ),
              title: Text(
                usernames[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.more_vert),
            ),

            Image.network(
              "https://picsum.photos/500/500?random=$index",
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [

                  GestureDetector(
                    onTap: () {
                      setPostState(() {
                        isLiked = !isLiked;
                        likeCount += isLiked ? 1 : -1;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                  ),

                  const SizedBox(width: 15),
                  const Icon(Icons.mode_comment_outlined),
                  const SizedBox(width: 15),
                  const Icon(Icons.send_outlined),
                  const Spacer(),
                  const Icon(Icons.bookmark_border),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "$likeCount likes",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text("Beautiful day 🌸"),
            ),

            const SizedBox(height: 15),
            const Divider(),
          ],
        );
      },
    );
  }
}