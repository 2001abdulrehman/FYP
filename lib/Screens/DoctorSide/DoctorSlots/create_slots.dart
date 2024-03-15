import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optiscan/constant.dart';

class CreateSlots extends StatefulWidget {
  String userID;
  CreateSlots({super.key, required this.userID});

  @override
  State<CreateSlots> createState() => _CreateSlotsState();
}

class _CreateSlotsState extends State<CreateSlots> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selecteddate = '';
  String selectedTimeStr = '';
  bool picked = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selecteddate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    picked = true;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 15.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: TextEditingController(text: selecteddate),
                  enabled: false,
                  decoration: const InputDecoration(
                    hintText: 'Choose Date',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                    selectedTimeStr = DateFormat('hh:mm a').format(
                      DateTime(
                        2022,
                        1,
                        1,
                        selectedTime.hour,
                        selectedTime.minute,
                      ),
                    );
                  });
                  debugPrint(selectedTimeStr);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 15.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: TextEditingController(text: selectedTimeStr),
                  enabled: false,
                  decoration: const InputDecoration(
                    hintText: 'Choose Time',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                createAppointment();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Create Appointment Slot',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createAppointment() {
    if (selecteddate.isNotEmpty && selectedTimeStr.isNotEmpty) {
      String appointmentDateTime = '$selecteddate $selectedTimeStr';

      FirebaseFirestore.instance
          .collection('appointments')
          .doc(widget.userID)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          // Document exists, update the array
          FirebaseFirestore.instance
              .collection('appointments')
              .doc(widget.userID)
              .update({
            'appointments': FieldValue.arrayUnion([appointmentDateTime]),
          }).then((value) {
            functions.popScreen(context);
            functions.showSnackbar(context, 'Appointment Slot Created');
          }).catchError((error) {
            functions.popScreen(context);
            functions.showSnackbar(
                context, 'Failed to create appointment slot');
            print("Failed to add appointment: $error");
          });
        } else {
          // Document doesn't exist, create it with the initial appointment
          FirebaseFirestore.instance
              .collection('appointments')
              .doc(widget.userID)
              .set({
            'appointments': [appointmentDateTime],
          }).then((value) {
            functions.popScreen(context);
            functions.showSnackbar(context, 'Appointment Slot Created');
          }).catchError((error) {
            functions.popScreen(context);
            functions.showSnackbar(
                context, 'Failed to create appointment slot');
            print("Failed to create document: $error");
          });
        }
      }).catchError((error) {
        functions.popScreen(context);
        functions.showSnackbar(
            context, 'Error occurred while checking document');
        print("Error checking document: $error");
      });
    } else {
      functions.popScreen(context);
      functions.showSnackbar(context, 'Please select date and time');
    }
  }
}
