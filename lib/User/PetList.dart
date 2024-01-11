import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_new/User/AddPetUpdates.dart';
import 'package:petcare_new/User/Add_Pet.dart';
import 'package:petcare_new/Doctor/DoctorProfileView.dart';
import 'package:petcare_new/User/User_Profile.dart';
import 'package:petcare_new/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetList extends StatefulWidget {
  const PetList({super.key});

  @override
  State<PetList> createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  var userId = "";

  @override
  void initState() {
    super.initState();
    // Call your function to retrieve user ID here
    retrieveUserID();
  }

  Future<dynamic> retrieveUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('name') ?? '';
      // Retrieve the user ID
    });
  }



  Future<List<QueryDocumentSnapshot>> fetchData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("petlist").get();
      return querySnapshot.docs;
    } catch (e) {
      // Handle errors, log or display a meaningful error message.
      print("Error fetching data: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SafeArea(
          child: Column(children: [
            // logout1(),
            SizedBox(
              height: 190,
              child: Expanded(
                child: Container(
                    height: 10,
                    color: Color.fromARGB(255, 255, 232, 223),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 160),
                      child: Center(
                          child: Text(
                        userId,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('petlist').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No Pets are Added'));
                }

                // Extract the documents from the snapshot
                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                // String petId = documents[0].id;

                if (documents.isNotEmpty) {
                  String customerId = documents[0].id;
                  String name = documents[0]["name"];
                  Future<void> share() async {
                    SharedPreferences spref =
                        await SharedPreferences.getInstance();
                    spref.setString('idpet', customerId);
                    spref.setString('namepet', name);
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Access data from each document in the collection
                      Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;
                      // Create a Container using the data
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPetUpdates(pet_id:documents[index].id),
                                ));
                          },
                          child: Container(
                            height: 80,
                            width: screenSize.width * 0.9,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.4,
                                    color: Color.fromARGB(255, 216, 191, 151)),
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                    child: Image.network(
                                      '${data['image']}',
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 27, top: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Pet Name : ${data["name"].toString()}',
                                          style: GoogleFonts.poppins(fontSize: 15),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Pet Age : ${data["age"].toString()}',
                                          style:  GoogleFonts.poppins(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 140),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 163, 202, 234),
                backgroundImage: AssetImage(
                  "asset/Avatar-Profile-Vector-PNG-File.png",
                ),
                radius: 50,
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 70),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 246, 216, 205),
              child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfile(),
                        ));
                  }),
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.only(right: 5,bottom: 15,top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
               
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton(
                     
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.black,
                        size: 23,
                      )),
                  FloatingActionButton(
                      backgroundColor: Color.fromARGB(255, 164, 125, 111),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPet(),
                            ));
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      )),
                     
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
