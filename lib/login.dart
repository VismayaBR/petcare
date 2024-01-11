import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_new/Admin/AdminTab.dart';
import 'package:petcare_new/Doctor%20or%20User.dart';
import 'package:petcare_new/Doctor/DoctorHome.dart';
import 'package:petcare_new/User/NavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> loginUser() async {
    try {
      const String adminEmail = 'admin@gmail.com';
      const String adminPassword = 'admin@123';

      if (email.text == adminEmail && password.text == adminPassword) {
        Fluttertoast.showToast(msg: 'Login Successful as Admin');
        //Redirect to the admin home page
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AdminTab();
        }));
        return;
      }
      // Check if the user with the provided email and password exists in the user table
      final QuerySnapshot<Map<String, dynamic>> customerSnapshot =
          await FirebaseFirestore.instance
              .collection('doctorlist')
              .where('email', isEqualTo: email.text)
              .where('password', isEqualTo: password.text)
              .where('status', isEqualTo: '1')
              .get();

      if (customerSnapshot.docs.isNotEmpty) {
        String userId = customerSnapshot.docs[0].id;
        String name = customerSnapshot.docs[0]["name"];
        String department = customerSnapshot.docs[0]["department"];
        String email = customerSnapshot.docs[0]["email"];
        String fees = customerSnapshot.docs[0]["fees"];
        String location = customerSnapshot.docs[0]["location"];
        String qualification = customerSnapshot.docs[0]["qualification"]; // Retrieve the ID from the first document

        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('id', userId);
        spref.setString('name', name);
        spref.setString('email', email);
        spref.setString('location', location);

        spref.setString('department', department);
        spref.setString('fees', fees); // Save the user ID to SharedPreferences
        spref.setString('qualification', qualification);

        Fluttertoast.showToast(msg: 'Login Successful as Doctor');
        print('Customer ID: $userId');

        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
          return DoctorHome();
        }));
        return;
      }
      final QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('userlist')
              .where('email', isEqualTo: email.text)
              .where('password', isEqualTo: password.text)
              .where('status', isEqualTo: '1')
              .get();
      if (userSnapshot.docs.isNotEmpty) {
        // print('object');
        var name = userSnapshot.docs[0]['name'];
        String email = userSnapshot.docs[0]["email"];
        String location = userSnapshot.docs[0]["location"];
        String contact = userSnapshot.docs[0]["phone"];
        String id = userSnapshot.docs[0].id.toString();
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$location');

        // Retrieve the ID from the first document

        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('name', name);
        spref.setString('email', email);
        spref.setString('location', location);
        spref.setString('contact', contact);
        spref.setString('id', id); // Save the user ID to SharedPreferences

        Fluttertoast.showToast(msg: 'Login Successful as user');
        print('Customer ID: $name');
        String userId = userSnapshot.docs[0].id;

        SharedPreferences spref2 = await SharedPreferences.getInstance();
        spref.setString('user_id', userId);

        print('Customer ID: $userId');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
          return Navigation();
        }));
      } else {
        print("object");
      }
    } catch (e) {
      print('Error logging in:');
      // Handle errors and show an error message to the user if needed
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: SizedBox(
              height: 120,
              width: 120,
              child: Image.asset(
                "asset/Screenshot.png",
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 22, bottom: 30),
              child: Text(
                "Login",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Color.fromARGB(255, 200, 139, 6)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 34, bottom: 5),
            child: Text(
              "Email",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    controller: email,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter your email"),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.4, color: Color.fromARGB(255, 200, 139, 6)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 34, bottom: 5, top: 15),
            child: Text(
              "Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: password,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter your password"),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.4, color: Color.fromARGB(255, 200, 139, 6)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 77.0,
                right: 77.0,
              ),
              child: InkWell(
                onTap: () {
                  if (formkey.currentState?.validate() ?? false) {
                    loginUser();
                  }

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => User_selection(),
                  //     ));
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 234, 227, 236),
                          blurRadius: 8,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromARGB(222, 192, 12, 12),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserSelection()));
                },
                child: const Text("Sign up")),
          )),
         const SizedBox(
            height: 45,
          )
        ]),
      ),
    );
  }
}
