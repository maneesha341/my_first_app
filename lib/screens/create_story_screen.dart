import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/app_data.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {

  Future<void> pickStory() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      AppData.stories.insert(0, File(image.path));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Story")),
      body: Center(
        child: ElevatedButton(
          onPressed: pickStory,
          child: const Text("Select Story Image"),
        ),
      ),
    );
  }
}