import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optiscan/Screens/AdminSide/AdminDashboard/add_store.dart';
import 'package:optiscan/Screens/AdminSide/AdminDashboard/non_verified_docs.dart';
import 'package:optiscan/Screens/AdminSide/AdminDashboard/registered_doctors.dart';
import 'package:optiscan/Screens/AdminSide/AdminDashboard/registered_stores.dart';
import 'package:optiscan/Screens/AdminSide/AdminDashboard/user_profiles.dart';
import 'package:optiscan/Screens/PatientSide/AvailableStores/all_stores.dart';
import 'package:optiscan/constant.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: scaffoldColor,
        title: Text(
          'Dashboard',
          style: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              functions.popScreen(context);
              functions.popScreen(context);
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: blueColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: blueColor.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0.0, 0.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesomeIcons.userNurse,
                          color: Colors.black,
                          size: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Total Doctor',
                                    style: TextStyle(
                                        color: blueColor, fontSize: 9)),
                                Text(
                                  '1024',
                                  style: TextStyle(
                                      color: blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: blueColor.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0.0, 0.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesomeIcons.calendar,
                          color: Colors.black,
                          size: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Total Appoiintments',
                                    style: TextStyle(
                                        color: blueColor, fontSize: 5)),
                                Text(
                                  '500+',
                                  style: TextStyle(
                                      color: blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: blueColor.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0.0, 0.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesomeIcons.user,
                          color: Colors.black,
                          size: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Total Patient',
                                    style: TextStyle(
                                        color: blueColor, fontSize: 10)),
                                Text(
                                  '3000+',
                                  style: TextStyle(
                                      color: blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: blueColor.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0.0, 0.0),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesomeIcons.person,
                          color: Colors.black,
                          size: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Total Users',
                                    style: TextStyle(
                                        color: blueColor, fontSize: 10)),
                                Text(
                                  '500+',
                                  style: TextStyle(
                                      color: blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () =>
                      functions.nextScreen(context, const RegisterDoctors()),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Verified\nDoctos',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      functions.nextScreen(context, const NonVerifiedDoctors()),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Non Verified\n Doctors',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => functions.nextScreen(context, const AddStore()),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Add \n Med Store',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      functions.nextScreen(context, const RegisteredStores()),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Registered\n Med Stores',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () =>
                      functions.nextScreen(context, const UserProfiles()),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Registered\n Patients',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    functions.popScreen(context);
                    functions.popScreen(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
