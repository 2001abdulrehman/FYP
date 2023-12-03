import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiscan/Screens/PatientSide/EyeScan/display_image.dart';
import 'package:optiscan/Screens/PatientSide/discalimer_screen.dart';
import 'package:optiscan/Screens/PatientSide/info_screen.dart';
import 'package:optiscan/constant.dart';

class EyeSCanIntro extends StatefulWidget {
  const EyeSCanIntro({super.key});

  @override
  State<EyeSCanIntro> createState() => _EyeSCanIntroState();
}

class _EyeSCanIntroState extends State<EyeSCanIntro> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    String? imagePath;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Row(
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
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: blueColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
      ),
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'HOLD YOUR PHONE TO EYE LEVEL \n KEEP SOME DISTANCE',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/eyescan.png',
              width: 250,
            ),
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
// Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        imagePath = image!.path;
                      });
                      functions.nextScreen(
                          context,
                          DisplayImage(
                            imagePath: '$imagePath',
                          ));
                    },
                    child: const Text(
                      'Open Gallery ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final XFile? pickedFile = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      if (pickedFile != null) {
                        setState(() {
                          imagePath = pickedFile.path;
                        });
                        functions.nextScreen(
                            context,
                            DisplayImage(
                              imagePath: '$imagePath',
                            ));
                      }
                    },
                    child: const Text(
                      'Open Camera ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      functions.nextScreen(context, const InfoScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffEDEDED),
                          borderRadius: BorderRadius.circular(10)),
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
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      functions.nextScreen(context, const DisclaimerScreen());
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xffEDEDED),
                            borderRadius: BorderRadius.circular(10)),
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
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
