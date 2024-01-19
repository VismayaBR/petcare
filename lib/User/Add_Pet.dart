import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare_new/User/NavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: InkWell(
                onTap: pickImage,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color.fromARGB(255, 255, 239, 233),
                    height: 150,
                    child: _image == null
                        ? Center(child: Icon(Icons.upload))
                        : Image.file(File(_image!.path), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34, top: 10, bottom: 4),
              child: Row(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
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
                        width: 1.4, color: Color.fromARGB(255, 200, 139, 6)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 38, top: 10, bottom: 4),
              child: Row(
                children: [
                  Text(
                    "Age",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
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
                          width: 1.4, color: Color.fromARGB(255, 200, 139, 6)),
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
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December',
                    ];

                    String currentMonth = monthNames[DateTime.now().month - 1];

                    await uploadImage(); // Make sure to call uploadImage before adding to Firestore
                    SharedPreferences spref =
                        await SharedPreferences.getInstance();
                    var sp = spref.getString('id');
                    await FirebaseFirestore.instance.collection("petlist").add({
                      'user_id': sp,
                      "name": name,
                      "age": age,
                      // "height": height,
                      // "weight": weight,
                      // "heartrate": heartrate,
                      // "bp": bp,
                      "month": currentMonth,
                      'image': imageUrl
                    });

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
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
    );
  }
}
