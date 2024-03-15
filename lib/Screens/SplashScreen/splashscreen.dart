import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Functions/functions.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorNav/doctor_nav.dart';
import 'package:optiscan/Screens/PatientSide/NavBar/navbar.dart';
import 'package:optiscan/Screens/SplashScreen/splash_options.dart';
import 'package:optiscan/Services/auth_service.dart';
import 'package:optiscan/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Functions functions = Functions();
  AuthService authService = AuthService();
  String? role;
  getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.uid)
          .get();
      role = userDoc['role'];
    }
  }

  getUserRole1() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(user.uid)
          .get();
      role = userDoc['role'];
    }
  }

  @override
  void initState() {
    getUserRole();
    getUserRole1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(150),
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/splashimagermbg.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        role == 'patient'
                            ? functions.nextScreen(
                                context, const PatientNavBar())
                            : role == 'doctor'
                                ? functions.nextScreen(
                                    context, const DoctorNav())
                                : functions.nextScreen(
                                    context, const SplashOptions());
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(150),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
