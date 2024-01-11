import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_new/Admin/DoctorList.dart';
import 'package:petcare_new/Admin/UserList.dart';
import 'package:petcare_new/login.dart';


class AdminTab extends StatefulWidget {
  const AdminTab({super.key});

  @override
  State<AdminTab> createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // title: CircleAvatar(
          //   radius: 30.r,
          //   backgroundImage: const AssetImage("assets/admin.png"),
          // ),
          actions: [
            IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
              return Login();
            }));
          }, icon: Icon(Icons.logout_rounded))],
        ),
        // backgroundColor: Colors.lightBlue,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      "User",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    )),
                    Tab(
                      child: Text(
                        "Mechanic",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // Creates border
                      color: Colors.brown),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.brown,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Expanded(
                child: TabBarView(children: [
              Center(child: Doctorlist()),
              Center(child: UserList())
            ]))
          ]),
        ),
      ),
    );
  }
}

