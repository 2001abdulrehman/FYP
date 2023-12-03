import 'package:flutter/material.dart';
import 'package:optiscan/constant.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: blueColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: InputBorder.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              top: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/zain.png'),
                                  radius: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Patient Name : Raja Zain',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Appointment Date : 11/5/2023',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Patient Name : MR. Raja Zain',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Patient Number : 097864576535',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
