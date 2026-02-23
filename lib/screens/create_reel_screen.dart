import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/app_data.dart';

class CreateReelScreen extends StatefulWidget {
  const CreateReelScreen({super.key});

  @override
  State<CreateReelScreen> createState() => _CreateReelScreenState();
}

class _CreateReelScreenState extends State<CreateReelScreen> {

  Future<void> pickReel() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      AppData.reels.insert(0, {
        "image": File(image.path),
        "likes": 0,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Reel")),
      body: Center(
        child: ElevatedButton(
          onPressed: pickReel,
          child: const Text("Select Reel Image"),
        ),
      ),
    );
  }
}