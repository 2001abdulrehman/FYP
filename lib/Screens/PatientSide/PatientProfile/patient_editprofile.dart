import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiscan/constant.dart';

class PatienEdittProfile extends StatefulWidget {
  const PatienEdittProfile({Key? key}) : super(key: key);

  @override
  State<PatienEdittProfile> createState() => _PatienEdittProfileState();
}

class _PatienEdittProfileState extends State<PatienEdittProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  Future<void> _getUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(user!.uid)
          .get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>;
      });
    }
  }

  Widget _buildEditIcon() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Change Profile Photo '),
                    const Divider(),
                    _buildOptionText('Upload Photo', blueColor, () async {
                      User? user = _auth.currentUser;
                      final pickedFile = await ImagePicker.platform
                          .getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        String imagePath =
                            'profile_images/${user!.uid}/${DateTime.now().millisecondsSinceEpoch}.png';
                        Reference storageReference =
                            _storage.ref().child(imagePath);

                        await storageReference.putFile(File(pickedFile.path));
                        String downloadURL =
                            await storageReference.getDownloadURL();
                        try {
                          await _firestore
                              .collection('patients')
                              .doc(user.uid)
                              .update({
                            'profileImage': downloadURL,
                          });
                          Navigator.pop(context);
                          _getUserData();
                        } catch (e) {}
                      }
                    }),
                    const Divider(),
                    _buildOptionText('Cancel', null, () {
                      functions.popScreen(context);
                    }),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Icon(
        FontAwesomeIcons.edit,
        color: blueColor,
      ),
    );
  }

  Widget _buildOptionText(String text, Color? color, Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            labelText,
            style: const TextStyle(
                color: Color(0xff717171), fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: blueColor, width: 1.3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: blueColor, width: 1.3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.3),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: blueColor, width: 1.3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoContainer(String labelText, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            labelText,
            style: const TextStyle(
                color: Color(0xff717171), fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black),
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              info,
              style: TextStyle(
                  color: Color(0xff000000), fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Color(0xff717171), fontWeight: FontWeight.bold),
                  ),
                  _buildEditIcon(),
                ],
              ),
              Center(
                child: userData == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(userData!['profileImage']),
                        backgroundColor: blueColor,
                        radius: 80,
                      ),
              ),
              const SizedBox(height: 10),
              if (userData != null) ...[
                _buildInfoContainer('Name', userData!['name']),
                _buildInfoContainer('Email', userData!['email']),
                _buildInfoContainer(
                    'Phone Number', userData!['patientPhoneNumber']),
              ],
              _buildTextFormField('New Password', newpassController),
              _buildTextFormField('Confirm Password', passController),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            "Changes Successfully",
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Icon(
                            Icons.check_circle,
                            color: blueColor,
                            size: 40,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                functions.popScreen(context);
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: blueColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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
