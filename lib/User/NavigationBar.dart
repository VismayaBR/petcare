import 'package:flutter/material.dart';
import 'package:petcare_new/Admin/DoctorList.dart';
import 'package:petcare_new/User/Appointments.dart';
import 'package:petcare_new/User/PetList.dart';
import 'package:petcare_new/User/UserDoctorList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var selectedindex = 0;

  void navigat(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  var list1 = [
    const PetList(),
   const UserDoctorlist(),
   const Appointments(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: list1.elementAt(selectedindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color.fromARGB(255, 11, 9, 148),
          currentIndex: selectedindex,
          onTap: navigat,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.pets_rounded, size: 20, color: Colors.black54),
                backgroundColor: Color.fromARGB(255, 131, 99, 31)),
            BottomNavigationBarItem(
              label: "Doctors",
              icon: Icon(Icons.people_alt, size: 20, color: Colors.black54),
              activeIcon: Icon(
                Icons.shop_2_outlined,
                size: 20,
                color: Colors.black,
              ),
              backgroundColor: Color.fromARGB(153, 9, 70, 0),
            ),
            BottomNavigationBarItem(
                label: "Appointments",
                icon: Icon(Icons.date_range_outlined,
                    size: 20, color: Colors.black54),
                backgroundColor: Color.fromARGB(255, 131, 99, 31)),
          ]),
    );
  }
}
