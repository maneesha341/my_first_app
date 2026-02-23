import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final int index;

  const PostWidget({super.key, required this.index});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  bool isLiked = false;
  int likeCount = 120;
  List<String> comments = [];

  // 🔥 Real Names List
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

  void openComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        TextEditingController controller = TextEditingController();

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: 500,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Comments",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),

                    Expanded(
                      child: comments.isEmpty
                          ? const Center(child: Text("No comments yet"))
                          : ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  ),
                                  title: Text(comments[index]),
                                );
                              },
                            ),
                    ),

                    const Divider(),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Add a comment...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                setModalState(() {
                                  comments.add(controller.text);
                                });
                                setState(() {});
                                controller.clear();
                              }
                            },
                            child: const Text(
                              "Post",
                              style:
                                  TextStyle(color: Colors.blue),
                            ),
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
    super.build(context);

    final String name =
        usernames[widget.index % usernames.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 🔹 HEADER
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/150?img=${widget.index + 3}",
            ),
          ),
          title: Text(
            name,
            style:
                const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text("2 hours ago",
              style: TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.more_vert),
        ),

        // 🔹 POST IMAGE
        Image.network(
          "https://picsum.photos/500/500?random=${widget.index}",
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        // 🔹 ACTION ROW
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;

                    if (isLiked) {
                      likeCount++;
                    } else {
                      likeCount--;
                    }
                  });
                },
                child: Icon(
                  isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      isLiked ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(width: 15),

              GestureDetector(
                onTap: openComments,
                child: const Icon(
                    Icons.mode_comment_outlined),
              ),

              const SizedBox(width: 15),
              const Icon(Icons.send_outlined),
              const Spacer(),
              const Icon(Icons.bookmark_border),
            ],
          ),
        ),

        // 🔥 LIKE COUNT
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "$likeCount likes",
            style:
                const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 5),

        // 🔥 CAPTION
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "$name enjoying the day ✨",
            style:
                const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),

        const SizedBox(height: 5),

        if (comments.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: openComments,
              child: Text(
                "View all ${comments.length} comments",
                style:
                    const TextStyle(color: Colors.grey),
              ),
            ),
          ),

        if (comments.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              comments.last,
              style:
                  const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

        const SizedBox(height: 20),
      ],
    );
  }
}