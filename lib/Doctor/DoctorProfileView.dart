import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var name;
  var email;
  var location;
  var contact;
  @override
  void initState() {
    fetchData();
    checkSlot();
  }

  var selectedTime;
  var selectedTime1;
  var token = TextEditingController();
  String dt1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var check;

  Future<void> checkSlot() async {
    SharedPreferences spref =await SharedPreferences.getInstance();
    var id =spref.getString('id');
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('slots')
        .where('doc_id', isEqualTo: id)
        .where('date', isEqualTo: dt1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Slots exist for the current date and logged-in doctor
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
         print('Slot is already added');
         setState(() {
           check ='Slot is already added';
         });
        // Access the slot data using doc.data()
        print('Slot ID: ${doc.id}, From: ${doc['from']}, To: ${doc['to']}, Token: ${doc['token']}');
      }
    } else {
      setState(() {
        check = 'Slot is not added';
      });
      // No slots found for the current date and logged-in doctor
      print('No slots found for the current date and logged-in doctor');
    }
  }





  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      // Handle the selected time as needed
      print("Selected time: ${picked.format(context)}");
      setState(() {
        selectedTime = picked;
      });
     
    }
  }
  Future<void> _selectTime1(BuildContext context) async {
    final TimeOfDay? picked1 = await showTimePicker(
      context: context,
      initialTime: selectedTime1 ?? TimeOfDay.now(),
    );

    if (picked1 != null) {
      // Handle the selected time as needed
      print("Selected time: ${picked1.format(context)}");
      setState(() {
        selectedTime1 = picked1;
      });
     
    }
  }

  fetchData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      name = spref.getString('name') ?? '';
      email = spref.getString('email') ?? '';
      location = spref.getString('location') ?? '';
      contact = spref.getString('contact') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                Text(name, style: GoogleFonts.poppins(fontSize: 13)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 250,
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
                            Text('Email',
                                style: GoogleFonts.poppins(fontSize: 13)),
                            Text(email, style: GoogleFonts.poppins(fontSize: 13)),
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
                            Text('Location',
                                style: GoogleFonts.poppins(fontSize: 13)),
                            Text(location,
                                style: GoogleFonts.poppins(fontSize: 13)),
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
                            Text('Contact',
                                style: GoogleFonts.poppins(fontSize: 13)),
                            Text(contact,
                                style: GoogleFonts.poppins(fontSize: 13)),
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
                            Text('Location',
                                style: GoogleFonts.poppins(fontSize: 13)),
                            Text('widget.location',
                                style: GoogleFonts.poppins(fontSize: 13)),
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
                            Text('Fee', style: GoogleFonts.poppins(fontSize: 13)),
                            Text('j', style: GoogleFonts.poppins(fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Edit Profile',
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 233, 222, 219),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Text(
              'ADD TODAYS SLOT',
              style:
                  GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            if(check=='Slot is not added')
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    color: Color.fromARGB(255, 247, 238, 235),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('From : '),
                                  Container(
                                      color: Color.fromARGB(255, 237, 229, 226),
                                    width: 120,
                                    child: InkWell(
                                      onTap: () => _selectTime(context),
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                            text: selectedTime != null
                                                ? selectedTime!.format(context)
                                                : '',
                                          ),
                                          decoration: InputDecoration(
                                            // border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(vertical: 6),
                                            suffixIcon: Icon(
                                              Icons.access_time,
                                              size: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('To : '),
                                  Container(
                                    color: Color.fromARGB(255, 237, 229, 226),
                                    width: 120,
                                    child: InkWell(
                                      onTap: () => _selectTime1(context),
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                            text: selectedTime1 != null
                                                ? selectedTime1!.format(context)
                                                : '',
                                          ),
                                          decoration: InputDecoration(
                                            // border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(vertical: 6),
                                            suffixIcon: Icon(
                                              Icons.access_time,
                                              size: 17,
                                              
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Token : '),
                              ),
                              SizedBox(
                                width: 85,
                                child: TextFormField(
                                  controller: token,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences spref = await SharedPreferences.getInstance();
                                    var id = spref.getString('id');
                                    FirebaseFirestore.instance.collection('slots').add({
                                      'doc_id': id,
                                      'from': selectedTime.format(context),
                                      'to': selectedTime1.format(context),
                                      'date': dt1,
                                      'token':int.parse(token.text),
                                     ' init_token': token.text
                                    });
                                  },
                                  child: Container(
                                   width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Add Slots',
                                        style: GoogleFonts.poppins(fontSize: 12),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromARGB(255, 223, 214, 212),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
             if(check=='Slot is already added')
             SizedBox(height: 30,),
             Center(child: Text("Today's Slot is already added !"))
          ],
        ),
      ),
    );
  }
}
