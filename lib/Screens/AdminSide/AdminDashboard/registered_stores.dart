import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optiscan/Screens/PatientSide/AvailableStores/store_Screen.dart';
import 'package:optiscan/constant.dart';

class RegisteredStores extends StatefulWidget {
  const RegisteredStores({Key? key}) : super(key: key);

  @override
  State<RegisteredStores> createState() => _RegisteredStoresState();
}

class _RegisteredStoresState extends State<RegisteredStores> {
  Stream fetchMedicalStores() {
    return FirebaseFirestore.instance.collection('medicalstores').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'Registered Store',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: fetchMedicalStores(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                  mainAxisExtent: 250,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];

                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;

                  return InkWell(
                    onTap: () => functions.nextScreen(
                        context,
                        StoreScreen(
                          storeName: data['storename'],
                          storeLocation: data['storelocation'],
                          storeAbout: data['storeabout'],
                          storeNumber: data['storenumber'],
                          storePicture: data['storepicture'],
                        )),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 04.0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data['storepicture']),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.center,
                            child: Text(data['storename']),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 5,
                            ),
                            child: InkWell(
                              onTap: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('medicalstores')
                                      .doc(doc.id)
                                      .delete();
                                  displayMessage(context, Colors.green,
                                      'Store deleted successfully');
                                } catch (e) {
                                  print('Error deleting store: $e');
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 30,
                                width: 70,
                                child: const Text(
                                  'Delete Store',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void displayMessage(BuildContext context, Color color, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
