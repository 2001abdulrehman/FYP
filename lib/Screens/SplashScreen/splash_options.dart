import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Functions/functions.dart';
import 'package:optiscan/Screens/AdminSide/admin_login.dart';
import 'package:optiscan/Screens/AuthScreens/doctor_login.dart';
import 'package:optiscan/Screens/AuthScreens/login.dart';
import 'package:optiscan/Screens/PatientSide/EyeScan/eyescan_intro.dart';
import 'package:optiscan/constant.dart';

class SplashOptions extends StatefulWidget {
  const SplashOptions({super.key});

  @override
  State<SplashOptions> createState() => _SplashOptionsState();
}

class _SplashOptionsState extends State<SplashOptions> {
  Functions functions = Functions();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: Image.asset(
                'assets/splashimagermbg.png',
                width: 300,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            InkWell(
              onTap: () {
                functions.nextScreen(context, const LoginPatient());
              },
              child: Container(
                width: width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: blueColor, borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Patient',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            InkWell(
              onTap: () {
                functions.nextScreen(
                  context,
                  const DoctorLogin(),
                );
              },
              child: Container(
                width: width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: blueColor, borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Doctor',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            InkWell(
              onTap: () {
                functions.nextScreen(
                  context,
                  const AdminLogin(),
                );
              },
              child: Container(
                width: width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: blueColor, borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Admin',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text.rich(
              TextSpan(
                text: "or continue as a ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: 'Guest',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          functions.nextScreen(context, const EyeSCanIntro());
                          setState(() {
                            guestEntry = true;
                          });
                        }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
