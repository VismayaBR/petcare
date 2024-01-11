import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_new/Admin/AdminTab.dart';


class DoctorView extends StatefulWidget {
  var name;
  var qualification;
  var email;
  var fees;
  var documents;
  String id;

  DoctorView({
    super.key,
    required this.name,
    required this.email,
    required this.qualification,
    required this.fees,
    required List<DocumentSnapshot<Object?>> documents,
    required this.id,
  });

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  String statusText = ''; // Added to hold status text

  @override
  void initState() {
    super.initState();
    // Fetch and set the status when the widget is initialized
    fetchStatus();
  }

  Future<void> fetchStatus() async {
    // Fetch the document from Firestore
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('doctorlist')
        .doc(widget.id)
        .get();

    // Get the status field from the document
    var status = documentSnapshot['status'];
    setState(() {
      statusText = status;
    });

    // Set the status text based on the retrieved status
  }

  @override
  Widget build(BuildContext context) {
    // var a = widget.documents;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctor Profile'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 163, 202, 234),
                    backgroundImage: AssetImage(
                      "asset/doctor.png",
                    ),
                    radius: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      " ${widget.name}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      " ${widget.email}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text('Qualification'),
                              Container(
                                // width: screenSize.width / 2.3,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(222, 225, 166, 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                    child: Text(
                                  " ${widget.qualification}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Fee'),
                              Container(
                                // width: screenSize.width / 2.3,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(222, 225, 166, 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                    child: Text(
                                  " ${widget.fees}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (statusText == '0')
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection('doctorlist')
                                .doc(widget.id)
                                .update({'status': '2'});
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return AdminTab();
                              },
                            ));
                          },
                          child: Container(
                            width: screenSize.width / 2.3,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(222, 224, 10, 10),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              "Reject",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection('doctorlist')
                                .doc(widget.id)
                                .update({'status': '1'});
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return AdminTab();
                              },
                            ));
                          },
                          child: Container(
                            width: screenSize.width / 2.3,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(222, 1, 154, 100),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              "Approve",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if(statusText=='1')
               Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
               
                      Expanded(
                        child: Container(
                          width: screenSize.width / 2.3,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(222, 1, 154, 100),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "Approved",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                 if(statusText=='2')
               Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
               
                      Expanded(
                        child: Container(
                          width: screenSize.width / 2.3,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "Rejected",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
            ]));
  }
}
