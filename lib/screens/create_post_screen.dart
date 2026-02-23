import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/app_data.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  File? selectedImage;
  final TextEditingController captionController =
      TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void submitPost() {
    if (selectedImage == null) return;

    AppData.posts.insert(0, {
      "image": selectedImage!,
      "caption": captionController.text.isEmpty
          ? "New Post ✨"
          : captionController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "New Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: submitPost,
            child: const Text(
              "Share",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [

          // 🔥 IMAGE PREVIEW (Instagram Style)
          selectedImage == null
              ? Container(
                  height: 300,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.image,
                        size: 80, color: Colors.grey),
                  ),
                )
              : Image.file(
                  selectedImage!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

          const Divider(),

          // 🔥 CAPTION ROW (Profile + TextField)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    CircleAvatar(
      radius: 20,
      backgroundImage:
          NetworkImage(AppData.profileImage),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppData.username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: captionController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Write a caption...",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    ),
  ],
)
          ),

          const Spacer(),

          // 🔥 CAMERA & GALLERY BUTTONS (Bottom Style)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [

                _buildPickerButton(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () =>
                      pickImage(ImageSource.camera),
                ),

                _buildPickerButton(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onTap: () =>
                      pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Icon(icon, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}