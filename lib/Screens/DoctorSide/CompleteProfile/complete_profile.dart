import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiscan/constant.dart';

class CompleteProfileScreen extends StatefulWidget {
  CompleteProfileScreen({super.key, required this.name});
  String name;
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  File? _dpImage;
  var imageSelected = false;
  dynamic dpUrl = "";

  Future pickImage() async {
    final pickedFile =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _dpImage = File(pickedFile.path);
        dpUrl = File(pickedFile.path);
        imageSelected = true;
      });
    }
  }

  Widget buildProfileImage() {
    return GestureDetector(
      onTap: pickImage,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 125,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            border: Border.all(width: 1.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: (!imageSelected)
              ? buildImagePlaceholder()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    dpUrl,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildImagePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.16,
          width: MediaQuery.of(context).size.width * 0.16,
          child: Image.asset(
            'assets/upload.png',
          ),
        ),
        const Text(
          'Choose Profile Image',
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget buildMultilineTextField(
      TextEditingController controller, String hintText) {
    return Container(
      height: 100,
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
          ),
        ],
      ),
      child: TextFormField(
        maxLines: 3,
        controller: controller,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText,
      TextInputType inputTime) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffDDDDDD),
            blurRadius: 15.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: inputTime,
        controller: controller,
        enabled: true,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildCompletedButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_dpImage == null ||
            doctorAboutController.text.isEmpty ||
            doctorSpecialtyController.text.isEmpty ||
            doctorServingHospitalController.text.isEmpty ||
            doctorPhoneNumberController.text.isEmpty ||
            doctorPmcController.text.isEmpty) {
          functions.showSnackbar(context, 'Please fill in all the fields.');
        } else {
          try {
            // Show circular indicator
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              barrierDismissible: false,
            );

            // Call the function to update profile
            await authService.completeUserProfile(
              profileImage: _dpImage!,
              about: doctorAboutController.text.trim(),
              specialty: doctorSpecialtyController.text.trim(),
              servingHospitalAddress:
                  doctorServingHospitalController.text.trim(),
              clinicAddress: doctorClinicController.text.trim(),
              context: context,
              docName: widget.name,
              pmcNumber: doctorPmcController.text.trim(),
              doctorPhoneNumber: doctorPhoneNumberController.text,
            );

            // Close the circular indicator dialog
            Navigator.pop(context);

            // Show completion message
          } catch (error) {
            // Handle errors, e.g., show an error message
            functions.showSnackbar(context, 'Error: $error');

            // Close the circular indicator dialog
            Navigator.pop(context);
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Completed',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        functions.showSnackbar(context, 'Please complete your profile first.');
        return false;
      },
      child: Scaffold(
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
                  buildProfileImage(),
                  buildMultilineTextField(doctorAboutController,
                      'Please write your about here ...'),
                  const SizedBox(height: 10),
                  buildTextField(doctorSpecialtyController, 'Your Specialty',
                      TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  buildTextField(doctorPmcController, 'PMC Number',
                      TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  buildTextField(doctorPhoneNumberController, 'Phone Number',
                      TextInputType.number),
                  const SizedBox(height: 10),
                  buildTextField(doctorServingHospitalController,
                      'Serving Hospital', TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  buildTextField(doctorClinicController,
                      'Clinic Address (optional)', TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  buildCompletedButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
