import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_new/Admin/AdminTab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerView extends StatefulWidget {
  var doc;
  var doc2;
  var doc1;

  String idcustomer;

  CustomerView({
    super.key,
    required this.doc,
    required this.doc1,
    required this.doc2,
    required this.idcustomer,
  }); //name//email//mobail

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
   String statusText = ''; // Added to hold status text

  @override
  void initState() {
    super.initState();
    // Fetch and set the status when the widget is initialized
    fetchStatus();
    share();
  }

  Future<void> fetchStatus() async {
    // Fetch the document from Firestore
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('userlist')
        .doc(widget.idcustomer)
        .get();

    // Get the status field from the document
    var status = documentSnapshot['status'];
    print('____________________$status');
    setState(() {
      statusText = status;
      
    });

    // Set the status text based on the retrieved status
  }


  var id = "";
  Future<void> share() async {
    var share = await SharedPreferences.getInstance();
    setState(() {
      id = share.getString("iduser").toString();
      // var email = share.getString("email");
      // var location = share.getString("");
      print(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        appBar: AppBar(
          title: Text(
            "Customer Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 163, 202, 234),
                      backgroundImage: AssetImage(
                        "asset/Avatar-Profile-Vector-PNG-File.png",
                      ),
                      radius: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        "${widget.doc}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        "${widget.doc1}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        "${widget.doc2}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              if(statusText=='0')
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('userlist')
                              .doc(widget.idcustomer)
                              .update({'status': '2'});
                          Navigator.pushReplacement(context, MaterialPageRoute(
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
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                              .collection('userlist')
                              .doc(widget.idcustomer)
                              .update({'status': '1'});
                          Navigator.pushReplacement(context, MaterialPageRoute(
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
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                        ),
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
                            color: Color.fromARGB(222, 224, 10, 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "Rejected",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
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
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "Approved",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                   
                  ],
                ),
              ),
              
            ]));
  }
}
