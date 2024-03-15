import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optiscan/constant.dart';

class NonVerifiedDoctors extends StatefulWidget {
  const NonVerifiedDoctors({Key? key}) : super(key: key);

  @override
  State<NonVerifiedDoctors> createState() => _NonVerifiedDoctorsState();
}

class _NonVerifiedDoctorsState extends State<NonVerifiedDoctors> {
  void _updateApprovalStatus(DocumentSnapshot doctor) {
    final doctorRef =
        FirebaseFirestore.instance.collection('doctors').doc(doctor.id);

    doctorRef.update({
      'approvalStatus': true,
    }).then((_) {
      functions.showSnackbar(context, 'Marked as Verified');
    }).catchError((error) {
      functions.showSnackbar(context, 'Error verifying doctor: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(FontAwesomeIcons.userNurse),
        automaticallyImplyLeading: false,
        title: Text(
          'Non Verified Doctors',
          style: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: scaffoldColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSearchField(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .where('approvalStatus', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doctor = snapshot.data!.docs[index];
                      return _buildDoctorItem(doctor, context);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
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
          hintText: 'Search Doctor',
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDoctorItem(DocumentSnapshot doctor, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xee565656),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 4.0),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildActionButtons(doctor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(doctor['profileImage']),
                  radius: 40,
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Dr : ${doctor['name']}',
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'PMC NO: ${doctor['pmcNumber']}',
                        style: const TextStyle(
                            color: Color(0xff717171),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Serving Hospital: ${doctor['servingHospital']}',
                        style: const TextStyle(
                            color: Color(0xff717171),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phone Number: ${doctor['doctorPhoneNumber']}',
                        style: const TextStyle(
                            color: Color(0xff717171),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Clinic Address: ${doctor['clinicAddress']}',
                        style: const TextStyle(
                            color: Color(0xff717171),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(DocumentSnapshot doctor) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildVerifyButton(doctor),
          const SizedBox(width: 50),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Widget _buildVerifyButton(DocumentSnapshot doctor) {
    return InkWell(
      onTap: () {
        _updateApprovalStatus(doctor);
      },
      child: Container(
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: blueColor, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          'Verify Doctor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: () {
        functions.showSnackbar(
            context, 'Request of Dr.Muhammd Kashif has been Deleted');
      },
      child: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
