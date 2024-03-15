import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image/image.dart' as img;
import 'package:optiscan/Screens/PatientSide/Results/results.dart';
import 'package:optiscan/constant.dart';
import 'package:path_provider/path_provider.dart';

class DisplayImage extends StatefulWidget {
  const DisplayImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  String resultMessage = 'No disease detected'; // Default message
  List? _output;
  @override
  void initState() {
    debugPrint(_output.toString());
    super.initState();
    loadModel();
  }

  void loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model/quantized_sig.tflite',
        labels: 'assets/labels.txt');
    setState(() {});
  }

  Future<void> classifyImageAndUpdateUI(String imagePath) async {
    try {
      // Preprocess the image
      img.Image processedImage = preprocessImage(File(imagePath));

      // Save the processed image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/processed_image4.jpg';
      final png = img.encodePng(processedImage);
      // Write the PNG formatted data to a file.
      try {
        await File(tempFilePath).writeAsBytes(png);
        debugPrint('saved processed image');
        debugPrint(tempFilePath);
      } catch (e) {
        throw Exception(e);
      }

      // Run model inference
      try {
        var output = await Tflite.runModelOnImage(
          path: tempFilePath,
        );
        setState(() {
          _output = output;
        });
        String label = extractLabel(output.toString());

        debugPrint(_output.toString());
        functions.nextScreen(
            context,
            Results(
              output: label,
            ));
      } catch (e) {
        throw Exception(e);
      }
    } catch (e) {
      print('Error during inference: $e');
      setState(() {
        resultMessage = 'Error during inference';
      });
    }
  }

  img.Image preprocessImage(File imageFile) {
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      throw Exception("Failed to decode image.");
    }

    // Resize the image to match the input size expected by the model (150x150)
    img.Image resizedImage = img.copyResize(image, width: 75, height: 75);

    // Convert the image to a byte buffer
    Uint8List buffer = resizedImage.getBytes();

    // Ensure the buffer size is exactly 22000 bytes
    if (buffer.length != 22500) {
      debugPrint(buffer.length.toString());
      throw Exception('Invalid input tensor size');
    }

    debugPrint(buffer.length.toString());

    return resizedImage;
  }

  Future<File> _saveTempImage(img.Image image) async {
    Directory tempDir = await getTemporaryDirectory();
    File tempImageFile = File('${tempDir.path}/temp_image.jpg');
    tempImageFile.writeAsBytesSync(img.encodeJpg(image));
    return tempImageFile;
  }

  String extractLabel(String text) {
    // Define a regular expression pattern to match the label
    RegExp regExp = RegExp(r"label:\s*(\w+)");

    // Extract the label using the pattern
    RegExpMatch match = regExp.firstMatch(text)!;

    // Check if a match is found and return the label

    return match.group(1)!; // Extracted label
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'Selected Picture',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: blueColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.file(
                File(widget.imagePath),
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                classifyImageAndUpdateUI(widget.imagePath);
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Start Scanning',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
