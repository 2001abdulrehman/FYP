import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:optiscan/constant.dart';

class GiveFeedBackScreen extends StatefulWidget {
  final String docId;
  GiveFeedBackScreen({Key? key, required this.docId});

  @override
  State<GiveFeedBackScreen> createState() => _GiveFeedBackScreenState();
}

class _GiveFeedBackScreenState extends State<GiveFeedBackScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();
  bool submitting = false;

  void submitFeedback() async {
    if (feedBackController.text.isEmpty) {
      functions.showSnackbar(context, 'Write your feed back first');
    } else {
      try {
        setState(() {
          submitting = true;
        });
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('patients')
              .doc(user.uid)
              .get();
          String userName = userSnapshot['name'];
          String userProfileImage = userSnapshot['profileImage'];

          // Storing feedback in Firestore
          await FirebaseFirestore.instance.collection('reviews').add({
            'reviewText': feedBackController.text,
            'reviewDate': Timestamp.now(),
            'name': userName,
            'reviewImage':
                userProfileImage, // Add logic to store image if required
            'docId': widget.docId,
          });

          // Show snackbar
          functions.showSnackbar(context, 'Your Feedback has been recorded');
          setState(() {
            submitting = false;
          });
        }
      } catch (e) {
        setState(() {
          submitting = false;
        });
        functions.showSnackbar(context, '$EdgeInsetsGeometry');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Give Your Feedback",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blueColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffDDDDDD),
                          blurRadius: 15.0,
                          spreadRadius: 2.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                    ),
                    height: height * 0.5,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Give your Feedback',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
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
                              controller: feedBackController,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                  hintText: 'Give Your Feedback Here ...',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: submitFeedback,
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                submitting ? 'Submitting' : 'Submit',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
