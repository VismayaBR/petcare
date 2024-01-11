import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare_new/User/NavigationBar.dart';

class AddPet extends StatefulWidget {
  const AddPet({super.key});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  var name;
  var age;
  var height;
  var weight;
  var heartrate;
  var bp;

  XFile? _image;
  String? imageUrl;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    try {
      XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _image = pickedImage;
        });

        // Upload the picked image
        await uploadImage();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImage() async {
    try {
      if (_image != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('uploads/${_image!.name}');

        await storageReference.putFile(File(_image!.path));

        // Get the download URL
        imageUrl = await storageReference.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle navigation back
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: InkWell(
                      onTap: pickImage,
                      child: SizedBox(
                        child: Icon(Icons.upload),
                      ),
                    ),
                  ),
                   Padding(
                    padding:
                        const EdgeInsets.only(left: 34, top: 10, bottom: 4),
                    child: Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) => name = value,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 11),
                              ),
                              hintText: "Enter pets name"),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 38, top: 10, bottom: 4),
                    child: Text(
                      "Age",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) => age = value,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 11),
                                ),
                                hintText: "Enter pets age"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 36, top: 10),
                        child: SizedBox(
                          width: screenSize.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Height",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 14, top: 10),
                        child: SizedBox(
                          width: screenSize.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Weight",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 27),
                          child: Container(
                            height: 48,
                            width: screenSize.width / 2.5,
                            child: Center(
                              child: TextFormField(
                                onChanged: (value) => height = value,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 11),
                                    ),
                                    hintText: "Enter height"),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 27),
                          child: Container(
                            height: 48,
                            width: screenSize.width / 2.5,
                            child: Center(
                              child: TextFormField(
                                onChanged: (value) => height = value,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 11),
                                    ),
                                    hintText: "Enter weight"),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 34,
                      bottom: 4,
                      top: 10,
                    ),
                    child: Text(
                      "Heart rate",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) => heartrate = value,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 11),
                                ),
                                hintText: "Enter heart rate"),
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
                    padding:
                        const EdgeInsets.only(left: 34, bottom: 7, top: 10),
                    child: Text(
                      "Bp",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) => bp = value,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 11),
                                ),
                                hintText: "Enter Bp"),
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
                          top: 20, left: 77.0, right: 77.0, bottom: 70),
                      child: InkWell(
                        onTap: () async {
                          List<String> monthNames = [
                            'January', 'February', 'March', 'April', 'May', 'June',
                            'July', 'August', 'September', 'October', 'November', 'December',
                          ];

                          String currentMonth = monthNames[DateTime.now().month - 1];

                          await uploadImage(); // Make sure to call uploadImage before adding to Firestore

                          await FirebaseFirestore.instance.collection("petlist").add({
                            "name": name,
                            "age": age,
                            "height": height,
                            "weight": weight,
                            "heartrate": heartrate,
                            "bp": bp,
                            "month": currentMonth,
                            'image': imageUrl
                          });

                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => Navigation(),
                          ));
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
                              color: Color.fromARGB(250, 2, 120, 63),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(fontSize: 16, color: Colors.white),
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
      ),
    );
  }
}
