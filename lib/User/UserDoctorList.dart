import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petcare_new/Admin/DoctorViewpage.dart';
import 'package:petcare_new/User/AddAppointments.dart';

class UserDoctorlist extends StatefulWidget {
  const UserDoctorlist({super.key});

  @override
  State<UserDoctorlist> createState() => _UserDoctorlistState();
}

class _UserDoctorlistState extends State<UserDoctorlist> {
  String dt1 = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<List<QueryDocumentSnapshot>> fetchData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("UserDoctorlist").get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<bool> isDoctorAvailableInSlots(String doctorId) async {
    CollectionReference slotsCollection =
        FirebaseFirestore.instance.collection('slots');

    QuerySnapshot querySnapshot =
        await slotsCollection.where('doc_id', isEqualTo: doctorId).where('date',isEqualTo: dt1).get();

    if (querySnapshot.docs.isNotEmpty) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (QueryDocumentSnapshot document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data.forEach((key, value) {
          print('$key: $value');
        });
      }

      // Return true to indicate that the doctor is available
      return true;
    } else {
      // Print a message indicating that no matching documents were found
      print('No matching documents found.');

      // Return false to indicate that the doctor is not available
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctorlist').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Doctors'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 17,
                          left: 20,
                          right: 20,
                        ),
                        child: InkWell(
                          onTap: () async {
                            print('__________________${documents[index].id}');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return AddAppointments(
                                id: documents[index].id.toString(),
                                name: data['name'],
                                department: data['department'],
                                quali: data['qualification'],
                                email: data['email'],
                                location: data['location'],
                                fee: data['fees'],
                                about: data['about'],
                                // token: data['token'],
                              );
                            }));
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 208, 194),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 120,
                                          color: Color.fromARGB(
                                              255, 248, 208, 194),
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.asset(
                                                "asset/doctor.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              data["name"].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              data["department"].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<bool>(
                                    future: isDoctorAvailableInSlots(
                                        documents[index].id),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool>
                                            availabilitySnapshot) {
                                      if (availabilitySnapshot
                                              .connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }

                                      bool isAvailable =
                                          availabilitySnapshot.data ?? false;

                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: isAvailable
                                              ? Color.fromARGB(255, 71, 197, 75)
                                              : const Color.fromARGB(255, 241, 96, 86),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            isAvailable
                                                ? 'Available'
                                                : 'Not Available',
                                            style: GoogleFonts.poppins(
                                                fontSize: 13),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
