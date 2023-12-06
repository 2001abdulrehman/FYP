import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:optiscan/constant.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String selectedHospital = 'Al Shifa Hospital';
  List<String> hospitals = [
    'Al Shifa Hospital',
    'Aga Khan  Hospital',
    'Shaukat Khanum  Cancer Hospital',
    'Liaquat National Hospital ',
    'Indus Hospital, Karachi',
    'Aga Khan Hospital, Karachi',
    'CMH Rawalpindi',
    'Jinnah Postgraduate Medical Centre ',
    'Punjab Institute of Cardiology',
    'Civil Hospital, Karachi',
  ];

  File? _dpImage;
  var imageSelected = false;
  dynamic dpUrl = "";
  Future pickImage() async {
    final pickedFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _dpImage = File(pickedFile.path);
        dpUrl = File(pickedFile.path);
        imageSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Complete Your Profile",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blueColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      height: 125,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      child: (!imageSelected)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: width * 0.16,
                                  width: width * 0.16,
                                  child: Image.asset(
                                    'assets/upload.png',
                                  ),
                                ),
                                const Text(
                                  'Choose Profile Image',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                dpUrl,
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: TextFormField(
                    maxLines: 3,
                    controller: doctorAboutController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        hintText: 'Please write your about here ...',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: doctorSpecialtyController,
                    enabled: true,
                    decoration: const InputDecoration(
                      hintText: 'Your Specialty',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Your Hospital',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      border: InputBorder.none,
                    ),
                    value: selectedHospital,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedHospital = newValue!;
                      });
                    },
                    items:
                        hospitals.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: doctorAddreessController,
                    enabled: true,
                    decoration: const InputDecoration(
                      hintText: 'Your Address',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: doctorClinicController,
                    enabled: true,
                    decoration: const InputDecoration(
                      hintText: 'Clinic Address',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    functions.showSnackbar(
                        context, 'Your Profile has been completed.');
                    functions.popScreen(context);
                    functions.popScreen(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Completed',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
