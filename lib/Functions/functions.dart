import 'package:flutter/material.dart';
import 'package:optiscan/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Functions {
  nextScreen(context, screenName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }

  popScreen(context) {
    Navigator.pop(context);
  }

  void openGoogleMaps(String address) async {
    // Encode the address to handle special characters
    String encodedAddress = Uri.encodeComponent(address);

    // Construct the Google Maps URL with the geo parameter

    var url = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

    // Check if the Google Maps app is installed
    await launch(url);
  }

  void makePhoneCall(String phoneNumber) async {
    // Check if the phone app is available
    if (await canLaunch('tel:$phoneNumber')) {
      // Launch the phone app with the specified phone number
      await launch('tel:$phoneNumber');
    } else {
      // If the app is not available, show an error
      throw 'Could not launch the phone app';
    }
  }

  void showDoctorContactBottomSheet(
      BuildContext context, String doctorPhoneNumber) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Chat on WhatsApp'),
              leading: Icon(Icons.chat),
              onTap: () {
                // Open WhatsApp chat
                openWhatsAppChat(doctorPhoneNumber);
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
            ListTile(
              title: Text('Call Doctor'),
              leading: Icon(Icons.phone),
              onTap: () {
                // Make a phone call
                makePhoneCall(doctorPhoneNumber);
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          ],
        );
      },
    );
  }

  void openWhatsAppChat(String phoneNumber) async {
    // Check if WhatsApp is installed
    var phone = phoneNumber;
    var url = 'https://wa.me/$phone';
    await launch(url);
  }

  launchWhatsapp() async {
    const phone = '+92 3102548084';
    const url = 'https://wa.me/$phone';
    await launch(url);
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: blueColor,
      duration: const Duration(seconds: 3),
      content: Text(
        message,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showTimeSlots(BuildContext context, double height) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: height / 3,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                    elevation: 2,
                    backgroundColor: blueColor,
                    label: const Text(
                      '11:15 AM',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    onDeleted: () async {},
                    deleteIcon: Icon(
                      Icons.edit,
                      color: blueColor,
                      size: 20,
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.0,
              ),
            ));
      },
    );
  }
}
