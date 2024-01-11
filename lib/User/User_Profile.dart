import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petcare_new/User/NavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  var name = "";
  var email = "";
  var location = "";
  var contact = "";
  var id = "";

  var name1 = TextEditingController();
  var email2 = TextEditingController();
  var location3 = TextEditingController();
  var contact4 = TextEditingController();

  void initState() {
    super.initState();

    // Call your function to retrieve user ID here
    retrieveUserID();
  }

  // void initstate() {
  //   user1 = TextEditingController(text: widget.docs66);
  //   user2 = TextEditingController(text: widget.name1);
  //   user3 = TextEditingController(text: widget.mob);
  //   user4 = TextEditingController(text: widget.password);
  // }
  final _formKey = GlobalKey<FormState>();

  Future<void> updateDocument() async {
    // Get a reference to the Firestore collection
    await FirebaseFirestore.instance.collection('userlist').doc(id).update({
      'name': name1.text,
      'email': email2.text,
      "location": location3.text,
      "contact": contact4.text,
    });

     SharedPreferences spref = await SharedPreferences.getInstance();
     setState(() {
        spref.setString('name',name1.text);
     spref.setString('email',email2.text);
     spref.setString('location',location3.text);
     spref.setString('contact',contact4.text);
     });
    


    print('Document successfully updated!');
  }

  Future<dynamic> retrieveUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      location = prefs.getString('location') ?? '';
      contact = prefs.getString('contact') ?? '';
      id = prefs.getString('id') ?? '';

      setState(() {
        name1 = TextEditingController(text: name);
        email2 = TextEditingController(text: email);
        location3 = TextEditingController(text: location);
        contact4 = TextEditingController(text: contact);
      });
      print(id);
      print(contact);
      print(email);
      print(location);
      print(name); // Retrieve the user ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Form(
      key: _formKey,
      child: ListView(children: [
        Stack(
          children: [
           
            Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 163, 202, 234),
                        backgroundImage: AssetImage(
                          "asset/Avatar-Profile-Vector-PNG-File.png",
                        ),
                        radius: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 34, bottom: 5),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            height: 62,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your  name';
                                  }
                                  return null;
                                },
                                controller: name1,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11),
                                    ),
                                    hintText: "Enter your name"),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.4,
                                    color: Color.fromARGB(255, 200, 139, 6)),
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 34, bottom: 5, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            height: 62,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                      .hasMatch(value)) {
                                    return 'Invalid email format';
                                  }
                                  return null;
                                },
                                controller: email2,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11),
                                    ),
                                    hintText: "Enter your email"),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.4,
                                    color: Color.fromARGB(255, 200, 139, 6)),
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 34, bottom: 5, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            height: 62,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your location';
                                  }
                                  return null;
                                },
                                controller: location3,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11),
                                    ),
                                    hintText: "Enter your location"),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.4,
                                    color: Color.fromARGB(255, 200, 139, 6)),
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 34, bottom: 5, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Contact",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            height: 62,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Invalid phone number format';
                                  }
                                  return null;
                                },
                                controller: contact4,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 11),
                                    ),
                                    hintText: "Enter contact number"),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.4,
                                    color: Color.fromARGB(255, 200, 139, 6)),
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 34, left: 77.0, right: 77.0, bottom: 20),
                          child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState?.validate() ??
                                  false) {
                                await updateDocument();
                  
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Navigation(),
                                    ));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Color.fromARGB(255, 234, 227, 236),
                                      blurRadius: 8,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  color: Color.fromARGB(222, 2, 161, 130),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                  child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    ));
  }
}
