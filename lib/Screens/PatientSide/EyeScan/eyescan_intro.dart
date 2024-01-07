import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiscan/Screens/PatientSide/EyeScan/display_image.dart';
import 'package:optiscan/Screens/PatientSide/discalimer_screen.dart';
import 'package:optiscan/Screens/PatientSide/info_screen.dart';
import 'package:optiscan/constant.dart';

import '../../../Functions/functions.dart';

class EyeSCanIntro extends StatefulWidget {
  const EyeSCanIntro({Key? key}) : super(key: key);

  @override
  State<EyeSCanIntro> createState() => _EyeSCanIntroState();
}

class _EyeSCanIntroState extends State<EyeSCanIntro> {
  final ImagePicker _picker = ImagePicker();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HOW TO SCAN ',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                CupertinoIcons.qrcode,
                color: Colors.white,
              ),
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'HOLD YOUR PHONE TO EYE LEVEL \n KEEP SOME DISTANCE',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/eyescan.png',
              width: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              'LOOK AT THIS FOCAN POINT',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'MAINTAIN YOUR EYES POSITION INSIDE \n THE SCANNER FRAME',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Follow On Screen Instruction',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(
                    label: 'Open Gallery',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  ActionButton(
                    label: 'Open Camera',
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoButton(
                      onTap: () =>
                          Functions().nextScreen(context, const InfoScreen())),
                  DisclaimerButton(
                      onTap: () => Functions()
                          .nextScreen(context, const DisclaimerScreen())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
      Functions().nextScreen(
        context,
        DisplayImage(
          imagePath: '$imagePath',
        ),
      );
    }
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ActionButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  final VoidCallback onTap;

  const InfoButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              CupertinoIcons.info_circle_fill,
              color: blueColor,
            ),
            const Text(
              'INFO',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisclaimerButton extends StatelessWidget {
  final VoidCallback onTap;

  const DisclaimerButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'DISCLAIMER',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
