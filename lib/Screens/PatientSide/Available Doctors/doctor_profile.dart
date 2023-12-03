import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/book_appointment_screen.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/feedback_screen.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/give_feedback_screen.dart';
import 'package:optiscan/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  DateTime selectedDate = DateTime.now();
  bool picked = false;
  String address = '';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
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
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/zain.png'),
                            radius: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Doctor Zain',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Specialty',
                                  style: TextStyle(
                                      color: Color(0xff6B6B6B),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Pindi, Pakistan',
                                  style: TextStyle(
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
                    const Text(
                      'Meet Zain, your dedicated healthcare partner. As a passionate and experienced [specialty] practitioner, I am committed to providing personalized and compassionate care. Join me on this journey towards better health, where your well-being is my top priority',
                      style: TextStyle(
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
                            String encodedAddress = Uri.encodeComponent(
                                doctorAddreessController.text);

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
                                context, BookAppointmentScreen());
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
                                context, '03231559163');
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
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  child: const Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/feedback_image.png'),
                                        radius: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Abdul Rehman',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              'Dr. Zain is a remarkable doctor',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              '29-11-2023 ',
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            functions.nextScreen(context, FeedBackScreen());
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
                            // functions.showFeedBackSheet(context, height,
                            //     () async {
                            //   functions.popScreen(context);
                            //   functions.showSnackbar(context,
                            //       'your feedback has been recorded. Thankyou');
                            // });
                            functions.nextScreen(
                                context, const GiveFeedBackScreen());
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
