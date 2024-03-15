import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/book_appointment_screen.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/feedback_screen.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/give_feedback_screen.dart';
import 'package:optiscan/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatefulWidget {
  String doctorPicture;
  String doctorName;
  String doctorSpecialty;
  String doctorAbout;
  String doctorNumber;
  String doctorUserId;
  String clinicAddress;
  String hospitalAddress;
  DoctorProfileScreen(
      {Key? key,
      required this.doctorPicture,
      required this.doctorAbout,
      required this.doctorName,
      required this.doctorNumber,
      required this.doctorSpecialty,
      required this.doctorUserId,
      required this.clinicAddress,
      required this.hospitalAddress});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  DateTime selectedDate = DateTime.now();
  bool picked = false;
  String address = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Doctor Profile",
          style: TextStyle(color: Colors.white),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.doctorPicture),
                            radius: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  widget.doctorName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Specialty:${widget.doctorSpecialty}',
                                  style: const TextStyle(
                                      color: Color(0xff6B6B6B),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Serving Hospital: ${widget.hospitalAddress}',
                                  style: const TextStyle(
                                      color: Color(0xff6B6B6B),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Clinic Address: ${widget.clinicAddress}',
                                  style: const TextStyle(
                                      color: Color(0xff6B6B6B),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      widget.doctorAbout,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            // Encode the address to handle special characters
                            String encodedAddress =
                                Uri.encodeComponent(widget.hospitalAddress);

                            var url =
                                'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

                            // Check if the Google Maps app is installed
                            await launch(url);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 90,
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Get Direction',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            functions.nextScreen(
                                context,
                                BookAppointmentScreen(
                                  docID: widget.doctorUserId,
                                  docImage: widget.doctorPicture,
                                  docName: widget.doctorName,
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 120,
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Book Appointment',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            functions.showDoctorContactBottomSheet(
                                context, widget.doctorNumber);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 90,
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Call Now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('reviews')
                            .where('docId', isEqualTo: widget.doctorUserId)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('This doctor has no reviews.'),
                            );
                          } else {
                            final reviewData = snapshot.data!.docs;

                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final review = reviewData[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(review['reviewImage']),
                                        radius: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              review['name'],
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              review['reviewText'],
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            functions.nextScreen(
                                context,
                                FeedBackScreen(
                                  doctorUserId: widget.doctorUserId,
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text('Show More Reviews'),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            functions.nextScreen(
                                context,
                                GiveFeedBackScreen(
                                  docId: widget.doctorUserId,
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text('Give Your Feedback'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
