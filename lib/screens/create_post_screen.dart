import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/widgets/custom_field.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser);
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? selectedImages;
  final User? user = FirebaseAuth.instance.currentUser;

  List<Widget> imageWidgets = [];

  Future<void> pickImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();

    setState(() {
      selectedImages = pickedImages;
      imageWidgets = selectedImages!
          .map((XFile image) => Image.file(File(image.path)))
          .toList();
    });
  }

  Future<void> onPressed() async {
    final String uid = user!.uid;

    final post = {
      'timestamp': FieldValue.serverTimestamp(),
      'title': titleController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'uid': uid,
    };

    final DocumentReference postRef =
        await FirebaseFirestore.instance.collection('posts').add(post);
    for (var image in selectedImages!) {
      final String postID = postRef.id;
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('posts/$postID/${image.path.split('/').last}');
      final UploadTask uploadTask = storageRef.putFile(File(image.path));

      await uploadTask.whenComplete(() => print('Image uploaded'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'ENTER THE FOLLOWING DETAILS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              customField(titleController, 'Title'),
              const SizedBox(height: 16),
              customField(descriptionController, 'Description'),
              const SizedBox(height: 16),
              customField(locationController, 'Location'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Pick Images',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              if (selectedImages != null)
                Column(
                  children: imageWidgets,
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
