import 'package:flutter/material.dart';
import 'package:optiscan/constant.dart';

class StoreScreen extends StatefulWidget {
  final String? storeName;
  final String? storeLocation;
  final String? storeNumber;
  final String? storeAbout;
  final String? storePicture;
  StoreScreen(
      {super.key,
      this.storeName,
      this.storeLocation,
      this.storeAbout,
      this.storeNumber,
      this.storePicture});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'Store Direction',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: blueColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.storePicture!), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.storeName!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.storeAbout!,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: InkWell(
              onTap: () {
                functions.makePhoneCall(
                  widget.storeNumber!,
                );
              },
              child: Container(
                width: 130,
                decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      Text(
                        'Call Now',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: InkWell(
            onTap: () {
              functions.openGoogleMaps(
                widget.storeLocation!,
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage('assets/map.png')),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.storeName!,
                      style: TextStyle(color: blueColor),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
