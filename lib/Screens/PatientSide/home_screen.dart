import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/Available%20Doctors/all_doctors.dart';
import 'package:optiscan/Screens/PatientSide/AvailableStores/all_stores.dart';
import 'package:optiscan/Screens/PatientSide/EyeScan/eyescan_intro.dart';
import 'package:optiscan/constant.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  List imageList = [
    {"id": 1, "image_path": 'assets/sliderimg.png'},
    {"id": 2, "image_path": 'assets/sliderimg.png'},
    {"id": 3, "image_path": 'assets/sliderimg.png'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/feedback_image.png',
            ),
          ),
        ),
        title: const Text(
          'HI KASHIF',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
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
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: currentIndex == 1 ? blueColor : Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: currentIndex == 2 ? blueColor : Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: currentIndex == 3 ? blueColor : Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    )
                  ],
                ),
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
                      functions.nextScreen(context, const AllDoctors());
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
                            'Check Available\nDoctors >>',
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
                    onTap: () =>
                        functions.nextScreen(context, const AllStores()),
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
                            'Check Available\nStores >>',
                            style: TextStyle(
                                color: blueColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
