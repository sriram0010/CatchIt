import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'game.dart';
class ImagesScreen extends StatefulWidget {
  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  List<ImageData> images = List.generate(2, (index) => ImageData(null));

  Future<void> _pickImage(int index, ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        images[index].imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image List')),
      body: Column(
        children: [
          for (int index = 0; index < images.length; index++)
            Column(
              children: [
                if (images[index].imageFile != null)
                  Image.file(images[index].imageFile!),
                ElevatedButton(
                  onPressed: () => _pickImage(index, ImageSource.gallery),
                  child: Text('Select Image $index'),
                ),
              ],
            ),
          ElevatedButton(
            onPressed: () {
              // Perform an action with the updated images list

            },
            child: Text('Save Images'),
          ),
        ],
      ),
    );
  }
}


class ImageData {
  File? imageFile;

  ImageData(this.imageFile);
}
