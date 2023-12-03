import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Screens/DoctorSide/Appointments/completed_appointments.dart';
import 'package:optiscan/Screens/DoctorSide/Appointments/appointment_history.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorHome/doctor_home.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorProfile/doctor_profile.dart';
import 'package:optiscan/Screens/PatientSide/PatientProfile/patient_profile.dart';
import 'package:optiscan/Screens/PatientSide/about_screen.dart';
import 'package:optiscan/Screens/PatientSide/help_screen.dart';
import '../../../constant.dart';

class DoctorNav extends StatefulWidget {
  const DoctorNav({super.key});

  @override
  State<DoctorNav> createState() => _DoctorNavState();
}

class _DoctorNavState extends State<DoctorNav> {
  List<Widget?> screens = [
    const DoctorHome(),
    const CompletedAppointments(),
    const AppointmentHistory(),
    const DoctorProfile()
  ];
  int selectedIndex = 0;
  Widget? selectedScreen;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xffDDDDDD),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: 80,
        child: Row(
          children: [
            buildNavigationItems(width, Icons.home, 0, 'Home'),
            buildNavigationItems(width, Icons.book, 1, 'Appointments'),
            buildNavigationItems(width, Icons.history, 2, 'History'),
            buildNavigationItems(
                width, CupertinoIcons.profile_circled, 3, 'Profile')
          ],
        ),
      ),
    );
  }

  Widget buildNavigationItems(width, IconData icon, int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: SizedBox(
          height: 80,
          width: width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: index == selectedIndex ? blueColor : Colors.grey,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 10,
                    color: index == selectedIndex ? blueColor : Colors.grey),
              )
            ],
          )),
    );
  }
}
