import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/widgets/custom_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isLoading = false;
  bool type = false;

  void gettype() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userType = prefs.getBool('isUser');

    setState(() {
      type = userType ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    gettype();
  }

  final TextEditingController titleController = TextEditingController();
  bool isvolunteer = false;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? selectedImages;
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
    setState(() {
      isLoading =
          true; // Set isLoading to true when starting the loading process
    });

    final User? user = FirebaseAuth.instance.currentUser;

    final String uid = user!.uid;

    final post = {
      'timestamp': FieldValue.serverTimestamp(),
      'title': titleController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'uid': uid,
      'votes': 0,
      'progress': 0,
      'organisationanme': "",
      'isvolunteer': isvolunteer
    };

    final DocumentReference postRef =
        await FirebaseFirestore.instance.collection('posts').add(post);
    for (var image in selectedImages!) {
      final String postID = postRef.id;
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('posts/$postID/${image.path.split('/').last}');
      final UploadTask uploadTask = storageRef.putFile(File(image.path));

      await uploadTask.whenComplete(() {
        print('Image uploaded');
      });
    }

    // After the loading is complete, set isLoading back to false
    setState(() {
      isLoading = false;
    });
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
              OutlinedButton(
                onPressed: pickImage,
                style: const ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  overlayColor: MaterialStatePropertyAll(Colors.orange),
                ),
                child: const Text(
                  'Pick Images',
                ),
              ),
              type
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 100,
                        ),
                        const Text('Is This a Volunteer job?'),
                        Checkbox(
                          value: isvolunteer,
                          onChanged: (value) => setState(
                            () {
                              isvolunteer = value!;
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              if (selectedImages != null)
                Column(
                  children: imageWidgets,
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading ? null : onPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Submit',
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
