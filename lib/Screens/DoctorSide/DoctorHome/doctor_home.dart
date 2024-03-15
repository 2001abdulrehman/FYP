import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optiscan/Functions/functions.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorSlots/create_slots.dart';
import 'package:optiscan/Screens/PatientSide/EyeScan/eyescan_intro.dart';
import 'package:optiscan/constant.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int currentIndex = 0;
  List imageList = [
    {"id": 1, "image_path": 'assets/sliderimg.png'},
    {"id": 2, "image_path": 'assets/sliderimg.png'},
    {"id": 3, "image_path": 'assets/sliderimg.png'},
  ];
  Functions functions = Functions();
  List<String> timeSlots = [];
  void _showBottomSheet(BuildContext context, String docId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => CreateSlots(
              userID: docId,
            ));
  }

  User? _user;
  Map<String, dynamic>? _userData;

  Future<void> _getUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(_user!.uid)
          .get();
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
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: _userData == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    _userData!['profileImage'],
                  ),
                ),
        ),
        title: _userData == null
            ? const SizedBox()
            : Text(
                'HI ${_userData!['name']}',
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print(currentIndex);
                },
                child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 120,
                      scrollPhysics: BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: InkWell(
                  onTap: () {
                    functions.nextScreen(context, const EyeSCanIntro());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: Image.asset(
                            'assets/fulleyescan.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Full Eye\nscan >>',
                          style: TextStyle(
                              color: blueColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: InkWell(
                  onTap: () {
                    _showBottomSheet(context, _userData!['uid']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: Image.asset(
                            'assets/doctor.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Create \nTime Slots >>',
                          style: TextStyle(
                              color: blueColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                'Your Slots',
                style: TextStyle(color: blueColor, fontSize: 15),
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: _userData != null
                    ? FirebaseFirestore.instance
                        .collection('appointments')
                        .doc(_userData!['uid'])
                        .snapshots()
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    Set<String> dateSet = {}; // Use Set to store unique dates
                    Map<String, List<String>> dateToTimeSlotsMap = {};
                    if (snapshot.hasData && snapshot.data!.exists) {
                      Map<String, dynamic>? data =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      if (data != null && data['appointments'] != null) {
                        List<dynamic> appointments = data['appointments'];
                        for (var appointment in appointments) {
                          List<String> parts = appointment.split(' ');
                          String date = parts[0];
                          String time = parts[1] +
                              ' ' +
                              parts[2]; // Combine time and AM/PM
                          dateSet.add(date); // Add each unique date to the Set
                          if (!dateToTimeSlotsMap.containsKey(date)) {
                            dateToTimeSlotsMap[date] = [];
                          }
                          dateToTimeSlotsMap[date]!.add(time);
                        }
                      }
                    }
                    return Expanded(
                      child: SizedBox(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: dateSet.length,
                          itemBuilder: (context, index) {
                            String date =
                                dateSet.elementAt(index); // Get date from Set
                            return GestureDetector(
                              onTap: () {
                                // Show bottom sheet with corresponding time slots when date is tapped
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
                                  style: const TextStyle(color: Colors.white),
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
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimePicker(int index) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      setState(() {
        timeSlots[index] = formattedTime;
      });
    }
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
          height: MediaQuery.of(context).size.height / 3,
          child: ListView.builder(
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(timeSlots[index]),
                trailing: IconButton(
                  onPressed: () async {
                    String appointmentDateTime =
                        '$selectedDate ${timeSlots[index]}';
                    debugPrint(appointmentDateTime);
                    try {
                      // Delete the time slot from Firestore
                      await FirebaseFirestore.instance
                          .collection('appointments')
                          .doc(_userData!['uid'])
                          .update({
                        'appointments':
                            FieldValue.arrayRemove([appointmentDateTime]),
                      });
                      functions.popScreen(context);
                      functions.showSnackbar(context,
                          'Time slot deleted successfully from Firestore.');
                    } catch (error) {
                      functions.showSnackbar(context,
                          'Failed to delete time slot from Firestore: $error');
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
