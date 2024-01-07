import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optiscan/Services/auth_service.dart';
import 'package:optiscan/constant.dart';

import '../../Functions/functions.dart';
import '../DoctorSide/CompleteProfile/complete_profile.dart';

class SignupDoctor extends StatefulWidget {
  const SignupDoctor({super.key});

  @override
  State<SignupDoctor> createState() => _SignupDoctorState();
}

class _SignupDoctorState extends State<SignupDoctor> {
  bool obsecure = false;
  bool checkbox = false;
  Functions functions = Functions();
  AuthService authService = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
          child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    'assets/splashimage.png',
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
                                    color: blueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            buildSocialNetworkIcons(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                              child: Text(
                                'or Signup With Email',
                                style: TextStyle(
                                    color: Color(0xff7F7F7F),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Full Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            buildInputField('Full Name', nameController),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            buildInputField('Email', emailController),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            buildPasswordInputField(),
                            const SizedBox(
                              height: 15,
                            ),
                            buildPrivacyCheckbox(),
                            buildSignUpButton(),
                            const SizedBox(
                              height: 10,
                            ),
                            buildLoginLink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      )),
    );
  }

  Widget buildSocialNetworkIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialNetworkIcon(FontAwesomeIcons.facebook),
        const SizedBox(width: 15),
        buildSocialNetworkIcon(FontAwesomeIcons.instagram),
        const SizedBox(width: 15),
        buildSocialNetworkIcon(FontAwesomeIcons.linkedin),
      ],
    );
  }

  Widget buildSocialNetworkIcon(IconData icon) {
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
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }

  Widget buildInputField(String labelText, TextEditingController controller) {
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
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPasswordInputField() {
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Password';
            }
            return null;
          }),
    );
  }

  Widget buildPrivacyCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: checkbox,
          onChanged: (value) {
            setState(() {
              checkbox = !checkbox;
            });
          },
        ),
        Text(
          'I agree with Privacy and Policy',
          style: TextStyle(
              color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildSignUpButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState?.validate() == true && checkbox == true) {
          if (_formKey.currentState?.validate() == true) {
            setState(() {
              isLoading =
                  true; // Set loading to true when starting account creation
            });

            User? user = await authService.signUpWithEmailAndPassword(
                emailController.text.trim(),
                passController.text.trim(),
                nameController.text.trim(),
                'doctors',
                'doctor');

            setState(() {
              isLoading =
                  false; // Set loading to false when account creation is complete
            });

            if (user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully registered as ${user.email}'),
                  duration: Duration(seconds: 2),
                ),
              );
              print('User registered: ${user.email}');
              functions.nextScreen(
                context,
                 CompleteProfileScreen(name: nameController.text.trim(),),
              );
            } else {
              // User registration failed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to register user. Please try again.'),
                  duration: Duration(seconds: 2),
                ),
              );
              print('Failed to register user');
            }
          }
        }
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget buildLoginLink() {
    return Text.rich(
      TextSpan(
        text: "Already have an Account? ",
        style: const TextStyle(
            color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Login',
            style: TextStyle(
                color: blueColor, fontSize: 15, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () => functions.popScreen(context),
          ),
        ],
      ),
    );
  }
}
