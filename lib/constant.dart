import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Functions/functions.dart';

Color blueColor = Color(0xff167FFF);
Color scaffoldColor = Color(0xffF8F8F8);
Functions functions = Functions();
AuthService authService = AuthService();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController newpassController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController feedBackController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController storeNameController = TextEditingController();
TextEditingController storeAboutController = TextEditingController();
TextEditingController storePhoneNumberController = TextEditingController();
TextEditingController storeLocationController = TextEditingController();
TextEditingController appointmentDateController = TextEditingController();
TextEditingController doctorAboutController = TextEditingController();
TextEditingController doctorServingHospitalController = TextEditingController();
TextEditingController doctorSpecialtyController = TextEditingController();
TextEditingController doctorPmcController = TextEditingController();
TextEditingController doctorPhoneNumberController = TextEditingController();
TextEditingController doctorClinicController = TextEditingController();
TextEditingController searchController = TextEditingController();
bool guestEntry = false;

final auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

User? user;
Map<String, dynamic>? userData;
