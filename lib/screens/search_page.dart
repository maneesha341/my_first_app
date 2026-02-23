import 'package:flutter/material.dart';
import 'profile_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  List<String> accounts = [
    "account",
    "account_123",
    "maneesha",
    "flutter_dev",
    "insta_user",
    "coding_girl"
  ];

  List<Map<String, dynamic>> photos = [
    {"image": "https://picsum.photos/400/600?random=1", "views": "1.2K views"},
    {"image": "https://picsum.photos/400/600?random=2", "views": "5.4K views"},
    {"image": "https://picsum.photos/400/600?random=3", "views": "892 views"},
    {"image": "https://picsum.photos/400/600?random=4", "views": "2.1K views"},
    {"image": "https://picsum.photos/400/600?random=5", "views": "7.8K views"},
    {"image": "https://picsum.photos/400/600?random=6", "views": "3.4K views"},
    {"image": "https://picsum.photos/400/600?random=7", "views": "9.1K views"},
    {"image": "https://picsum.photos/400/600?random=8", "views": "640 views"},
    {"image": "https://picsum.photos/400/600?random=9", "views": "4.3K views"},
  ];

  @override
  Widget build(BuildContext context) {
    List<String> filteredAccounts = accounts
        .where((user) =>
            user.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: _searchController.text.isEmpty
          ? buildPhotoGrid()
          : buildAccountList(filteredAccounts),
    );
  }

  Widget buildPhotoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullImageScreen(
                  imageUrl: photos[index]["image"],
                  views: photos[index]["views"],
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    photos[index]["image"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                photos[index]["views"],
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildAccountList(List<String> users) {
    if (users.isEmpty) {
      return const Center(
        child: Text(
          "No accounts found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(users[index]),
          subtitle: const Text("View Profile"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(
                  username: users[index],
                  profileImage:
                      "https://i.pravatar.cc/150?img=${index + 1}",
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;
  final String views;

  const FullImageScreen({
    Key? key,
    required this.imageUrl,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: InteractiveViewer(
                child: Image.network(imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              views,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}