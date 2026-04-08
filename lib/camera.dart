import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MaterialApp(
      home: MyCamera(),
      debugShowCheckedModeBanner: false,
    ));

class MyCamera extends StatefulWidget {
  const MyCamera({super.key});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  File? cameraFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> selectFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        cameraFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: selectFromCamera,
                child: const Text('Select the image from camera')),
            const SizedBox(height: 20),
            SizedBox(
                height: 200,
                width: 300,
                child: cameraFile == null
                    ? const Center(child: Text('Sorry Nothing Was Selected!'))
                    : Image.file(cameraFile!))
          ],
        ),
      ),
    );
  }
}
