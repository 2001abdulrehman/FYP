import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Functions/functions.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorSlots/create_slots.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorSlots/slots.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/all_doctors.dart';
import 'package:optiscan/Screens/PatientSide/AvailableStores/all_stores.dart';
import 'package:optiscan/Screens/PatientSide/EyeScan/eyescan_intro.dart';
import 'package:optiscan/constant.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  Functions functions = Functions();
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => CreateSlots());
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
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/zain.png',
            ),
          ),
        ),
        title: const Text(
          'HI DR.Zain',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 10),
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
                    _showBottomSheet(context);
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
              AvailabilityWidget()
            ],
          ),
        ),
      ),
    );
  }
}
