import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/PatientAppointments/patient_appointments.dart';
import 'package:optiscan/Screens/PatientSide/PatientProfile/patient_editprofile.dart';
import 'package:optiscan/Screens/PatientSide/about_screen.dart';
import 'package:optiscan/Screens/PatientSide/info_screen.dart';
import 'package:optiscan/constant.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
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

  Widget _buildProfileAvatar() {
    return Center(
      child: userData == null
          ? const CircularProgressIndicator()
          : CircleAvatar(
              backgroundImage: NetworkImage(userData!['profileImage']),
              backgroundColor: blueColor,
              radius: 80,
            ),
    );
  }

  Widget _buildProfileName() {
    return userData == null
        ? const SizedBox()
        : Text(
            'Hi , ${userData!['name']}',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          );
  }

  Widget _buildMenuItem(
      {required String text,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
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
                  children: [Icon(icon), Text(text)],
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff717171)),
              ],
            ),
          ),
        ),
      ),
    );
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
            _buildProfileAvatar(),
            const SizedBox(height: 10),
            _buildProfileName(),
            const SizedBox(height: 30),
            _buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onTap: () {
                functions.nextScreen(context, PatienEdittProfile());
              },
            ),
            _buildMenuItem(
              text: 'Info',
              icon: Icons.help,
              onTap: () {
                functions.nextScreen(context, InfoScreen());
              },
            ),
            _buildMenuItem(
              text: 'About Us',
              icon: Icons.info,
              onTap: () {
                functions.nextScreen(context, AboutScreen());
              },
            ),
            _buildMenuItem(
              text: 'Logout',
              icon: Icons.exit_to_app,
              onTap: () async {
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
