import 'package:flutter/material.dart';
import 'profile_screen.dart';
class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final List<Map<String, dynamic>> reels = [
  {
    "image": "https://picsum.photos/500/900?random=1",
    "username": "maneesha",
    "profile":
        "https://i.pravatar.cc/150?img=1",
    "likes": 120,
    "comments": <String>[],
    "isLiked":false,
  },
  {
    "image": "https://picsum.photos/500/900?random=2",
    "username": "riya",
    "profile":
        "https://i.pravatar.cc/150?img=5",
    "likes": 89,
    "comments": <String>[],
      "isLiked":false,
  },
  {
    "image": "https://picsum.photos/500/900?random=3",
    "username": "arjun",
    "profile":
        "https://i.pravatar.cc/150?img=8",
    "likes": 240,
    "comments": <String>[],
      "isLiked":false,
  },
];

  void openComments(int index) {
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 500,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text("Comments",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),

                    // Comment List
                    Expanded(
                      child: reels[index]["comments"].isEmpty
                          ? const Center(child: Text("No comments yet"))
                          : ListView.builder(
                              itemCount:
                                  reels[index]["comments"].length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  ),
                                  title: Text(
                                      reels[index]["comments"][i]),
                                );
                              },
                            ),
                    ),

                    const Divider(),

                    // Add Comment
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  hintText: "Add a comment...",
                                  border: InputBorder.none),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                setModalState(() {
                                  reels[index]["comments"]
                                      .add(controller.text);
                                });
                                setState(() {});
                                controller.clear();
                              }
                            },
                            child: const Text("Post",
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: reels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTap: () {
              setState(() {
                reels[index]["likes"]++;
              });
            },
            child: Stack(
              children: [

                // Image
                Positioned.fill(
                  child: Image.network(
                    reels[index]["image"],
                    fit: BoxFit.cover,
                  ),
                ),

                // Right Side Icons
                Positioned(
                  right: 15,
                  bottom: 120,
                  child: Column(
                    children: [

                      // Like Button
                     IconButton(
  icon: Icon(
    reels[index]["isLiked"]
        ? Icons.favorite
        : Icons.favorite_border,
    color: reels[index]["isLiked"]
        ? Colors.red
        : Colors.white,
    size: 30,
  ),
  onPressed: () {
    setState(() {
      if (reels[index]["isLiked"]) {
        reels[index]["likes"]--;
      } else {
        reels[index]["likes"]++;
      }

      reels[index]["isLiked"] =
          !reels[index]["isLiked"];
    });
  },
),
                      Text(
                        reels[index]["likes"].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      // Comment Button
                      IconButton(
                        icon: const Icon(Icons.mode_comment_outlined,
                            color: Colors.white, size: 30),
                        onPressed: () => openComments(index),
                      ),
                      Text(
                        reels[index]["comments"].length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      const Icon(Icons.send_outlined,
                          color: Colors.white, size: 30),
                    ],
                  ),
                ),
                

                // Profile Section
                Positioned(
  left: 15,
  bottom: 40,
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            username: reels[index]["username"],
            profileImage: reels[index]["profile"],
          ),
        ),
      );
    },
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(reels[index]["profile"]),
        ),
        const SizedBox(width: 10),
        Text(
          reels[index]["username"],
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
),
              ],
            ),
          );
        },
      ),
    );
  }
}