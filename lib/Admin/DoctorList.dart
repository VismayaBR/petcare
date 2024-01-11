import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_new/Admin/DoctorViewpage.dart';


class Doctorlist extends StatefulWidget {
  const Doctorlist({super.key});

  @override
  State<Doctorlist> createState() => _DoctorlistState();
}

class _DoctorlistState extends State<Doctorlist> {
  Future<List<QueryDocumentSnapshot>> fetchData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("doctorlist").get();
      return querySnapshot.docs;
    } catch (e) {
      // Handle errors, log or display a meaningful error message.
      print("Error fetching data: $e");
      return [];
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

          // Extract the documents from the snapshot
          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              // Access data from each document in the collection
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              // Create a Container using the data
              return Padding(
                padding: const EdgeInsets.only(
                  top: 17,
                  left: 20,
                  right: 20,
                ),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorView(
                                  documents: documents,
                                  id: documents[index].id,
                                  name: data["name"],
                                  email: data["email"],
                                  qualification: data["qualification"],
                                  fees: data["fees"],
                                )));
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 1,
                        //   color: Color.fromARGB(255, 164, 125, 111),
                        // ),
                        color: Color.fromARGB(255, 248, 208, 194),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                color: Color.fromARGB(255, 248, 208, 194),
                                child: Center(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          "asset/doctor.png",
                                          fit: BoxFit.cover,
                                        ))),
                              ),
                            ),
                             Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(
                                data["name"].toString(),
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              Text(
                                data["department"].toString(),
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              RatingBar(
                                filledIcon: Icons.star,
                                size: 20,
                                emptyIcon: Icons.star_border,
                                onRatingChanged: (value) =>
                                    debugPrint('$value'),
                                initialRating: 3,
                                maxRating: 5,
                              )
                            ],
                          ),
                        ),
                          ],
                        ),
                       
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('doctorlist')
                                        .doc(documents[index].id)
                                        .delete();
                                    setState(() {
                                      documents.removeAt(index);
                                    });
                                  },
                                  child: Icon(Icons.delete,size: 20,)),
                                
                              
                            ],
                          ),
                        ),
                          SizedBox()
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),


    );
  }
}
