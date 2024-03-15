import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optiscan/constant.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String docID;
  final String docName;
  final String docImage;
  const BookAppointmentScreen(
      {Key? key,
      required this.docID,
      required this.docImage,
      required this.docName})
      : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String selectedDate = '';
  String selectedTime = '';
  bool picked = false;
  Map<String, List<String>> dateToTimeSlotsMap = {};
  bool timeSelected = false;
  User? _user;
  Map<String, dynamic>? _userData;
  Future<void> _getUserData() async {
    _user = auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc =
          await firestore.collection('patients').doc(_user!.uid).get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Book Appointment",
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                            'Tap on Date to see available time slots and\nselect time and press on book appointment'),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('appointments')
                              .doc(widget.docID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              Set<String> dateSet =
                                  {}; // Use Set to store unique dates
                              Map<String, List<String>> dateToTimeSlotsMap = {};
                              if (snapshot.hasData && snapshot.data!.exists) {
                                Map<String, dynamic>? data = snapshot.data!
                                    .data() as Map<String, dynamic>?;
                                if (data != null &&
                                    data['appointments'] != null) {
                                  List<dynamic> appointments =
                                      data['appointments'];
                                  for (var appointment in appointments) {
                                    List<String> parts = appointment.split(' ');
                                    String date = parts[0];
                                    String time = parts[1] +
                                        ' ' +
                                        parts[2]; // Combine time and AM/PM
                                    dateSet.add(
                                        date); // Add each unique date to the Set
                                    if (!dateToTimeSlotsMap.containsKey(date)) {
                                      dateToTimeSlotsMap[date] = [];
                                    }
                                    dateToTimeSlotsMap[date]!.add(time);
                                  }
                                }
                              }
                              return SizedBox(
                                height: height / 3,
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: dateSet.length,
                                  itemBuilder: (context, index) {
                                    String date = dateSet
                                        .elementAt(index); // Get date from Set
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDate = date;
                                        });
                                        debugPrint(date);
                                        showTimeSlotsBottomSheet(context, date,
                                            dateToTimeSlotsMap[date] ?? []);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: Text(
                                          date,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedDate.isEmpty ||
                                  selectedTime.isEmpty) {
                                functions.showSnackbar(context,
                                    'Kindly select date and time first to book appointment.');
                              } else {
                                storeAppointmentData(
                                  date: selectedDate,
                                  docid: widget.docID,
                                  pimage: _userData!['profileImage'],
                                  pname: _userData!['name'],
                                  pnumber: _userData!['patientPhoneNumber'],
                                  status: 'pending',
                                  time: selectedTime,
                                  pid: _userData!['uid'],
                                  docimage: widget.docImage,
                                  docname: widget.docName,
                                );
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Book Appointment',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showTimeSlotsBottomSheet(
    BuildContext context,
    String selectedDate,
    List<String> timeSlots,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(timeSlots[index]),
                onTap: () {
                  setState(() {
                    selectedTime = timeSlots[index];
                  });
                  functions.popScreen(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected Time is $selectedTime'),
                    ),
                  );
                  debugPrint(selectedTime);
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> storeAppointmentData({
    required String date,
    required String docid,
    required String pimage,
    required String pname,
    required String pnumber,
    required String status,
    required String time,
    required String pid,
    required String docimage,
    required String docname,
  }) async {
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference bookedAppointments =
        firestore.collection('bookedappointments');

    try {
      await bookedAppointments.add({
        'date': date,
        'docid': docid,
        'pimage': pimage,
        'pname': pname,
        'pnumber': pnumber,
        'status': status,
        'time': time,
        'pid': pid,
        'docimage': docimage,
        'docname': docname
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment is booked'),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
