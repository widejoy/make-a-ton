import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_project/widgets/custom_field.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<Asset> selectedImages = <Asset>[];

  Future<void> pickImages() async {
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(
      maxImages: 5, // You can adjust the maximum number of images.
      enableCamera: true,
    );

    setState(() {
      selectedImages = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              onPressed: pickImages,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                'Pick Images',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Display selected images
            if (selectedImages.isNotEmpty)
              Column(
                children: [
                  const Text('Selected Images:'),
                  Column(
                    children: selectedImages.map((Asset asset) {
                      return AssetThumb(
                        asset: asset,
                        width: 300,
                        height: 300,
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the form submission with title, description, location, and selectedImages.
                },
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
    );
  }
}
