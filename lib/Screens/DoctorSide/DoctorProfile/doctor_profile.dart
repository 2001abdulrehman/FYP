import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optiscan/Screens/DoctorSide/Doctor%20Reviews/doctor_reviews.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorProfile/doctor_edit_profile.dart';
import 'package:optiscan/Screens/DoctorSide/PatientRecords/patient_records.dart';
import 'package:optiscan/Screens/PatientSide/PatientAppointments/patient_appointments.dart';
import 'package:optiscan/Screens/PatientSide/PatientProfile/patient_editprofile.dart';

import 'package:optiscan/constant.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late User? user;
  Map<String, dynamic>? userData;

  Future<void> _getUserData() async {
    debugPrint('running again');
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user!.uid)
          .get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            userData == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userData!['profileImage']),
                      backgroundColor: blueColor,
                      radius: 80,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            userData == null
                ? const SizedBox()
                : Text(
                    'HI ${userData!['name']}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorEditProfile(),
                  ),
                );
              },
            ),
            // CustomButton(
            //   icon: Icons.calendar_month,
            //   text: 'Patient Records',
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => PatientRecords(),
            //       ),
            //     );
            //   },
            // ),
            CustomButton(
              icon: Icons.reviews,
              text: 'My Reviews',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorReviews(),
                  ),
                );
              },
            ),
            CustomButton(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffDDDDDD),
                blurRadius: 6.0,
                spreadRadius: 2.0,
                offset: Offset(0.0, 5.0),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(icon),
                    Text(text),
                  ],
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xff717171),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
