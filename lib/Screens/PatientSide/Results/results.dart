import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/all_doctors.dart';
import 'package:optiscan/Screens/PatientSide/AvailableStores/all_stores.dart';
import 'package:optiscan/constant.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.save)),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'Your Report',
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/splashimagermbg.png',
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: blueColor),
                child: const Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Patient Name :",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: ' Kashif',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Patient Number :",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: ' 03456798576',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Time : 11:07 PM',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Date : 11-29-2023',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Test For',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Cataracts:",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: ' Not Found',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Glaucoma: ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: ' Found',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'We have a 70% confidence level that your eye is exhibiting symptoms indicative of a Glaucoma disease',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              guestEntry
                  ? Text('')
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            functions.nextScreen(context, const AllDoctors());
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Consult  Doctor',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            functions.nextScreen(context, const AllStores());
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Contact Store',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
