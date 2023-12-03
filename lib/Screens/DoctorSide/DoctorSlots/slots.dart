import 'package:flutter/material.dart';
import 'package:optiscan/Screens/DoctorSide/DoctorSlots/create_slots.dart';
import 'package:optiscan/constant.dart';

class AvailabilityWidget extends StatefulWidget {
  const AvailabilityWidget({super.key});

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  List<String> timeSlots = ['12:44 PM', '01:00 PM', '02:30 PM', '04:15 PM'];
  void _showTimePicker(int index) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime
          .format(context); // Formats time to 12-hour format with AM/PM

      setState(() {
        timeSlots[index] = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
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
                color: blueColor.withOpacity(0.6),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
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
