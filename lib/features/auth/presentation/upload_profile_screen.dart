import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({super.key});

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
  File? _pickedImage; // store picked image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A3E74)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Upload Profile',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("To create your new account, provide one of your photos."),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1A3E74),
                          width: 8,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: screenWidth / 3,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null,
                        child: _pickedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          label: const Text(
                            'Camera',
                            style: TextStyle(color: Color(0xFF1A3E74)),
                          ),
                        ),
                        const SizedBox(width: 16),

                        TextButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          label: const Text(
                            'Photos',
                            style: TextStyle(color: Color(0xFF1A3E74)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (screenWidth / 2) - 32,
                  height: 51,
                  child: context.secondaryButton(
                    onPressed: () {},
                    text: "Skip",
                    borderRadius: 8,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: (screenWidth / 2) - 32,
                  height: 51,
                  child: context.primaryButton(
                    onPressed: () {},
                    text: "Continue",
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
