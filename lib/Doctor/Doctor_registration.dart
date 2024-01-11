import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_new/login.dart';


class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});
  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  var name;
  var email;
  var password;
  var qualification;
  var fees;
  var department;
  var location;
  var about;
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
                "REGISTER",
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
              "Name",
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
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) => name = value,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter your name"),
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
            padding: EdgeInsets.only(left: 34, bottom: 5, top: 15),
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
                    onChanged: (value) => email = value,
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
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onChanged: (value) => password = value,
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
          Padding(
            padding: const EdgeInsets.only(left: 34, bottom: 5, top: 15),
            child: Text(
              "Qualification",
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
                        return 'Please enter your qualification';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter Qualification"),
                    onChanged: (value) => qualification = value,
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

          //
          Padding(
            padding: const EdgeInsets.only(left: 34, bottom: 5, top: 15),
            child: Text(
              "Department",
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
                        return 'Please enter your Department';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter Department"),
                    onChanged: (value) => department = value,
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
              "Location",
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
                        return 'Please enter your location';
                      }
                      return null;
                    },
                    onChanged: (value) => location = value,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter Location"),
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
              "About Me",
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
                        return 'Please enter about you';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "About you"),
                    onChanged: (value) => about = value,
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
              "Fees",
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
                        return 'Please enter your fees';
                      }
                      return null;
                    },
                    onChanged: (value) => fees = value,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 11),
                        ),
                        hintText: "Enter Fees"),
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
                onTap: () async {
                  print('object');
                    // if (formkey.currentState?.validate() ?? false) {
                      // Validation passed, navigate to User_Register2

                      await FirebaseFirestore.instance
                          .collection("doctorlist")
                          .add({
                        "about": about,
                        "location": location,
                        "name": name,
                        "email": email,
                        "password": password,
                        "qualification": qualification,
                        "fees": fees,
                        "department": department,
                        'status': "0",
                        
                      }).then((value) => 
                      Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>const Login(),
                              )));
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
                    "Register",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 45,
          )
        ]),
      ),
    );
  }
}
