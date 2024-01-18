import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_new/User/UserDoctorList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddAppointments extends StatefulWidget {
  var id;
  String name;
  String department;
  String quali;
  String email;
  String location;
  String fee;
  String about;

  AddAppointments({
    super.key,
    required this.id,
    required this.name,
    required this.department,
    required this.quali,
    required this.email,
    required this.location,
    required this.fee,
    required this.about,
  });

  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {
  @override
  void initState() {
    getToken();
  }

  String? toValue;
  String? fromValue;
  String? token;
  var tok;
  Future<void> getToken() async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('slots')
        .where('doc_id', isEqualTo: widget.id)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Access the first document from the snapshot
      DocumentSnapshot document = snapshot.docs.first;
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            print('________________________${data}____________________');

      print('________________________${data[' init_token']}____________________');
      tok = (int.parse(data[' init_token'].toString()) + 1).toString();
      setState(() {
        toValue = data['to'].toString();
        fromValue = data['from'].toString();
        token = data['token'].toString();

        print(tok);
        print('_____$token');
        print(
            '**************************${(int.parse(tok) - int.parse(token.toString())).toString()}');
      });

      print('To: $toValue');
    }
  }

  Future<void> _showBookingDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Successful'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your appointment has been booked successfully.'),
                Text(
                    'Token No : ${(int.parse(tok) - int.parse(token.toString())).toString()} '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // await _updateDoctorToken();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) {
                  return UserDoctorlist();
                }));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundImage: AssetImage('asset/male-avatar.jpg'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.name),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 220,
              width: double.infinity,
              color: Color.fromARGB(255, 247, 238, 235),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email'),
                          Text(widget.email),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Department'),
                          Text(widget.department),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Qualification'),
                          Text(widget.quali),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Location'),
                          Text(widget.location),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fee'),
                          Text(widget.fee),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Scheduled Time',
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('To : $toValue' ?? 'Loading...'),
                          Text('From : $fromValue' ?? 'Loading...'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'NO. OF TOKENS',
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 95, 62, 50),
                          ),
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Text(
                              token.toString() ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              width: double.infinity,
              color: Color.fromARGB(255, 247, 238, 235),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () async {
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection('slots')
                    .where('doc_id', isEqualTo: widget.id)
                    .get();

                for (QueryDocumentSnapshot document in querySnapshot.docs) {
                  // Get the reference for each document
                  DocumentReference docRef = FirebaseFirestore.instance
                      .collection('slots')
                      .doc(document.id);

                  // Update the 'token' field
                  await docRef.update({'token': FieldValue.increment(-1)});
                }

                SharedPreferences spref = await SharedPreferences.getInstance();
                var userId = spref.getString('user_id');
                print('object');
                String dt1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                String tm1 = DateFormat('HH:mm').format(DateTime.now());
                FirebaseFirestore.instance.collection('bookings').add({
                  'doctot_id': widget.id,
                  'user_id': userId,
                  'status': '0',
                  'token':
                      (int.parse(tok) - int.parse(token.toString())).toString(),
                  'date': dt1,
                  'time': tm1
                });

                _showBookingDialog();
              },
              child: Container(
                height: 40,
                width: double.infinity,
                child: Center(child: Text('Book Now')),
                color: Colors.brown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
