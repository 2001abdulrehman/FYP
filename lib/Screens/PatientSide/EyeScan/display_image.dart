import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:optiscan/Screens/PatientSide/Results/results.dart';
import 'package:optiscan/constant.dart';

class DisplayImage extends StatefulWidget {
  const DisplayImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  String resultMessage = 'No disease detected'; // Default message

  // void loadModel() async {
  //   await Tflite.loadModel(
  //     model: 'assets/model/model1.tflite',
  //   );
  // }

  // Future<List> classifyImage(String imagePath) async {
  //   var result = await Tflite.runModelOnImage(
  //     path: imagePath,
  //     imageMean: 0.0,
  //     imageStd: 255.0,
  //     numResults: 2,
  //     threshold: 0.2,
  //     asynch: true,
  //   );

  //   if (result == null) {
  //     // Handle the null case
  //     return [];
  //   }

  //   return result;
  // }

  // Future<void> classifyImageAndUpdateUI(String imagePath) async {
  //   var result = await classifyImage(imagePath);

  //   // Assuming the model returns a list of results, and you are interested in the first one
  //   String detectedDisease =
  //       result.isNotEmpty ? result[0]['label'] : 'No disease detected';

  //   setState(() {
  //     resultMessage = detectedDisease;
  //   });
  //   print(detectedDisease);
  // }

  @override
  void initState() {
    //loadModel();
    super.initState();
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
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              //functions.nextScreen(context, Results());
              //classifyImage(widget.imagePath);
              //classifyImageAndUpdateUI(widget.imagePath);
            },
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(30)),
              child: const Text(
                'Start Scanning',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          )
        ],
      )),
    );
  }
}
