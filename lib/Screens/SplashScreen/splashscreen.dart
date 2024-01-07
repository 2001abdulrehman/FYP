import 'package:flutter/material.dart';
import 'package:optiscan/Functions/functions.dart';
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
                        functions.nextScreen(context, const SplashOptions());
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
