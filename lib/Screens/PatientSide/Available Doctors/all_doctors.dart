import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/doctor_profile.dart';
import 'package:optiscan/constant.dart';

import 'book_appointment_screen.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({Key? key}) : super(key: key);

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10,
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('doctors')
                      .where('approvalStatus', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final doctors = snapshot.data!.docs;
                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                        mainAxisExtent: 220,
                      ),
                      itemCount: doctors.length,
                      itemBuilder: (_, index) {
                        final doctor = doctors[index];
                        return InkWell(
                          onTap: () => functions.nextScreen(
                            context,
                            DoctorProfileScreen(
                              doctorPicture: doctor['profileImage'],
                              doctorAbout: doctor['about'],
                              doctorName: doctor['name'],
                              doctorNumber: doctor['doctorPhoneNumber'],
                              doctorSpecialty: doctor['specialty'],
                              doctorUserId: doctor['uid'],
                              clinicAddress: doctor['clinicAddress'],
                              hospitalAddress: doctor['servingHospital'],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(doctor['profileImage']),
                                    radius: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(doctor['name']),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(doctor['specialty']),
                                  ),
                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      functions.nextScreen(
                                        context,
                                        BookAppointmentScreen(
                                          docID: doctor['uid'],
                                          docImage: doctor['profileImage'],
                                          docName: doctor['name'],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: blueColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 30,
                                      width: 140,
                                      child: const Text(
                                        'Book Appointment >',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
