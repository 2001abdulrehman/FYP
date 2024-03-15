import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiscan/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStore extends StatefulWidget {
  const AddStore({Key? key}) : super(key: key);

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  Future<void> uploadDataAndImage(File imageFile, String storeName,
      String storeNumber, String storeAbout, String storeLocation) async {
    try {
      setState(() {
        addingStore = true;
      });
      // Upload image to Firebase Storage
      String imageUrl = await uploadImage(imageFile);

      // Store data in Firestore
      await FirebaseFirestore.instance.collection('medicalstores').add({
        'storepicture': imageUrl,
        'storename': storeName,
        'storenumber': storeNumber,
        'storeabout': storeAbout,
        'storelocation': storeLocation,
      });
      setState(() {
        addingStore = false;
        storeNameController.clear();
        storePhoneNumberController.clear();
        storeAboutController.clear();
        storeLocationController.clear();
        _image = null;
      });
      displayMessage(context, Colors.green, 'Store is added');
    } catch (e) {
      setState(() {
        addingStore = false;
      });
      displayMessage(context, Colors.red, '$e');
    }
  }

  /// this function will put the image in fire base storage then we will
  /// call this function in a function that will store the uploaded link of the pic in firebase
  Future<String> uploadImage(File imageFile) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('store_images/${DateTime.now().millisecondsSinceEpoch}');

    UploadTask uploadTask = storageReference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask;

    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  bool selectedImage = false;
  XFile? _image;
  bool addingStore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        title: Text(
          'Add Medical Store',
          style: TextStyle(color: blueColor),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final imagePicker = ImagePicker();
                  final XFile? pickedFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = pickedFile;
                      selectedImage = true;
                    });
                  }
                },
                child: Container(
                  height: _image == null ? 100 : null,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: blueColor),
                  ),
                  child: _image == null
                      ? const Text('Add Store Image+')
                      : Image.file(
                          File(_image!.path), // Convert XFile to File
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              buildInputField('Enter Store Name', storeNameController),
              const SizedBox(height: 10),
              buildInputField('Enter Store Number', storePhoneNumberController),
              const SizedBox(height: 10),
              buildInputField('Enter Store About', storeAboutController),
              const SizedBox(height: 10),
              buildInputField('Enter Store Location', storeLocationController),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (storeNameController.text.isEmpty ||
                      storePhoneNumberController.text.isEmpty ||
                      storeAboutController.text.isEmpty ||
                      storeLocationController.text.isEmpty ||
                      _image!.path.isEmpty) {
                    displayMessage(
                        context, Colors.red, 'Please fill all fields');
                  } else {
                    uploadDataAndImage(
                        File(_image!.path),
                        storeNameController.text,
                        storePhoneNumberController.text,
                        storeAboutController.text,
                        storeLocationController.text);
                  }
                },
                child: Container(
                  height: 40,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    addingStore ? 'Adding' : 'Add Store',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String hintText, TextEditingController controller) {
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
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: InputBorder.none),
      ),
    );
  }

  void displayMessage(BuildContext context, Color color, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
