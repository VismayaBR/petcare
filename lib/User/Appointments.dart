import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Map<String, dynamic>> doctorNames = [];

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var userId = spref.getString('id');
    print(userId);

    try {
      // Fetch data from the 'bookings' collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings').where('user_id',isEqualTo: userId).get();

      // Extract data from the query result
      List<Map<String, dynamic>> bookings = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
print(bookings);
      // Fetch user details for each booking
      for (var booking in bookings) {
        var userSnapshot = await FirebaseFirestore.instance
            .collection('doctorlist')
            .doc(booking['doctot_id'])
            .get();

        var userData = userSnapshot.data() as Map<String, dynamic>;
        print(userData);

        // Combine user details with booking details
        doctorNames.add({
          'doctor_id': booking['doctot_id'],
          'doctor_name': userData['name'],
          'email':userData['email'],
          'token':booking['token'],
          'date':booking['date'],
          'time':booking['time']
          // Add other fields as needed
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle errors, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: const Color.fromARGB(255, 243, 223, 215),
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return ListView.builder(
                  itemCount: doctorNames.length,
                  itemBuilder: (context, index) {
                    return Card(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          
                          trailing: Column(
                            children: [
                              Text('Token : ${doctorNames[index]['token'].toString()}',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text(doctorNames[index]['date'],style: GoogleFonts.poppins(fontSize: 13),),
                              Expanded(child: Text(doctorNames[index]['time'],style: GoogleFonts.poppins(fontSize: 13),))
                            ],
                          ),
                          title: Text(doctorNames[index]['doctor_name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doctorNames[index]['email'],style: GoogleFonts.poppins(fontSize: 13),),
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
                          // Add other fields as needed
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
