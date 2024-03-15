import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AvailabilityWidget extends StatefulWidget {
  String docID;
  AvailabilityWidget({Key? key, required this.docID});

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  List<String> timeSlots = []; // Updated to store fetched time slots

  @override
  void initState() {
    super.initState();
    // Fetch and set appointment slots when the widget initializes
    fetchAppointmentSlots();
  }

  void fetchAppointmentSlots() async {
    try {
      // Fetch appointment slots from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('appointments')
          .doc(widget.docID)
          .get();

      // Check if document exists and contains appointment slots
      if (snapshot.exists && snapshot.data()!['appointments'] != null) {
        List<dynamic> appointments = snapshot.data()!['appointments'];
        setState(() {
          timeSlots = appointments
              .map<String>((appointment) => appointment
                  .split(' ')[1]) // Extracting time from appointment string
              .toList();
        });
      }
    } catch (error) {
      print("Error fetching appointment slots: $error");
    }
  }

  // Function to show time picker
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 5,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTap: () {
              _showTimePicker(index);
            },
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.6),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    timeSlots[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        timeSlots.removeAt(index);
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
