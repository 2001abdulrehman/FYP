import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/doctor_profile.dart';
import 'package:optiscan/constant.dart';

import 'book_appointment_screen.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({super.key});

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Available Doctors',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blueColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      mainAxisExtent: 220),
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () =>
                          functions.nextScreen(context, DoctorProfileScreen()),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage('assets/zain.png'),
                                radius: 50,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text('Doctor Zain'),
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text('Specialty'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Location:Pindi',
                                  style: TextStyle(
                                      color: blueColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  functions.nextScreen(
                                      context, BookAppointmentScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: blueColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 30,
                                  width: 70,
                                  child: const Text(
                                    'Book Appointment >',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
