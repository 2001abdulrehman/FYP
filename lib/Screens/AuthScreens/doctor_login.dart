import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optiscan/Screens/AuthScreens/doctor_signup.dart';
import 'package:optiscan/constant.dart';

import '../../Functions/functions.dart';
import '../DoctorSide/DoctorNav/doctor_nav.dart';

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  bool obsecure = false;
  Functions functions = Functions();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {}

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset(
                'assets/splashimagermbg.png',
                width: 200,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Enter Via Social Networks',
                            style: TextStyle(
                                color: blueColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildSocialIconsRow(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Text(
                            'or Login With Email',
                            style: TextStyle(
                                color: Color(0xff7F7F7F),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        buildEmailTextField(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        buildPasswordTextField(),
                        const SizedBox(
                          height: 15,
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Text('Forgot Password?'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildLoginButton(context),
                        const SizedBox(
                          height: 15,
                        ),
                        buildSignUpText(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSocialIconsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialIcon(FontAwesomeIcons.facebook),
        const SizedBox(width: 15),
        buildSocialIcon(FontAwesomeIcons.instagram),
        const SizedBox(width: 15),
        buildSocialIcon(FontAwesomeIcons.linkedin),
      ],
    );
  }

  Widget buildSocialIcon(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0xffDDDDDD),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: Icon(iconData, color: Colors.grey),
    );
  }

  Widget buildEmailTextField() {
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
        controller: emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildPasswordTextField() {
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
        obscureText: obsecure,
        controller: passController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obsecure = !obsecure;
              });
            },
            icon: Icon(
              obsecure ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true; // Set isLoading to true when sign-in process starts
        });
        try {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );

          // Check approval status here
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final userDoc = await FirebaseFirestore.instance
                .collection('doctors')
                .doc(user.uid)
                .get();
            final approvalStatus = userDoc['approvalStatus'];
            final role = userDoc['role'];
            if (approvalStatus == true && role == 'doctor') {
              functions.nextScreen(context, const DoctorNav());
              setState(() {
                guestEntry = false;
              });
            } else {
              // Show message if profile is not approved
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: blueColor,
                  duration: const Duration(seconds: 3),
                  content: const Text(
                    'Your profile is under approval. You will receive a confirmation call soon.',
                  ),
                ),
              );
              await FirebaseAuth.instance.signOut();
            }
          }
        } on FirebaseAuthException catch (e) {
          // Handle exceptions
        } finally {
          setState(() {
            isLoading =
                false; // Set isLoading to false when sign-in process completes
          });
        }
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: blueColor, borderRadius: BorderRadius.circular(30)),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
      ),
    );
  }

  Widget buildSignUpText(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: blueColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                functions.nextScreen(context, const SignupDoctor());
              },
          ),
        ],
      ),
    );
  }
}
