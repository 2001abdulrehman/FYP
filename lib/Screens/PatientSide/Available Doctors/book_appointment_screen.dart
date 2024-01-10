import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optiscan/constant.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String selecteddate = '';
  bool picked = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Book Appointment",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selecteddate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              picked = true;

                              print(selectedDate);
                              // appointmentDateController.text =
                              //     DateFormat('yyyy-MM-dd').format(selectedDate);
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
                            controller: appointmentDateController,
                            enabled: false,
                            decoration: InputDecoration(
                              // ignore: unnecessary_string_interpolations
                              hintText:
                                  picked ? '$selecteddate' : 'Choose Date',
                              hintStyle: TextStyle(
                                  color: picked ? Colors.black : Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
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
                          controller: phoneNumberController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'Enter PhoneNumber',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
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
                          controller: feedBackController,
                          textInputAction: TextInputAction
                              .newline, // Set text input action to newline
                          keyboardType: TextInputType
                              .multiline, // Set keyboard type to multiline
                          maxLines: 3, // Allow unlimited lines
                          decoration: const InputDecoration(
                            hintText: 'Type Your Message....',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: height / 5,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Chip(
                              elevation: 2,
                              backgroundColor: blueColor,
                              label: const Text(
                                '11:15 AM',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              deleteIcon: Icon(
                                Icons.edit,
                                color: blueColor,
                                size: 20,
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          functions.showSnackbar(
                              context, 'Appointment has been booked');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Book Appointment',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
