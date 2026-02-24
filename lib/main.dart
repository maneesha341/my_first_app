import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/auth_wrapper.dart';
import 'screens/home_screen.dart';
import 'screens/search_page.dart';
import 'screens/reels_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/create_post_screen.dart';
import 'screens/create_reel_screen.dart';
import 'screens/create_story_screen.dart';

/// 🔥 MAIN FUNCTION WITH FIREBASE
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

/// 🔥 ROOT APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(), // ✅ stays same
    );
  }
}

/// 🔥 MAIN NAVIGATION AFTER LOGIN
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const HomeScreen(),
    const SearchPage(),
    const SizedBox(),
    const ReelsScreen(),
    const ProfileScreen(
      username: "meghana",
      profileImage: "https://i.pravatar.cc/150?img=1",
    ),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showPostOptions();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  /// 🔥 CREATE POST / REEL / STORY
  void _showPostOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 320,
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Create",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPostOption(
                    icon: Icons.photo_library,
                    label: "Post",
                  ),
                  _buildPostOption(
                    icon: Icons.video_library,
                    label: "Reel",
                  ),
                  _buildPostOption(
                    icon: Icons.menu_book,
                    label: "Story",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostOption({
    required IconData icon,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);

        if (label == "Post") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreatePostScreen(),
            ),
          );
        }

        if (label == "Reel") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateReelScreen(),
            ),
          );
        }

        if (label == "Story") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateStoryScreen(),
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28),
          ),
          const SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
    );
  }
}