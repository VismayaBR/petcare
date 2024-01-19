import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_new/User/graph/UpdateBp.dart';
import 'package:petcare_new/User/graph/UpdateHeight.dart';
import 'package:petcare_new/User/graph/UpdateWeight.dart';
import 'package:petcare_new/User/graph/hr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Graph extends StatefulWidget {
  String pet_id;
  Graph({Key? key, required this.pet_id}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  var petName = "Loading..."; // Initial placeholder value
  var age = "Loading..."; // Initial placeholder value
  bool isLoading = true;
  var image; // Flag to track whether data is being loaded

  @override
  void initState() {
    super.initState();
    getData();
    fetchWeight();
    fetchHeight();
    fetchBp();
    fetchHr();
  }

  List weightData = [];
  List heightData = [];
  List bpData = [];
  List hrData = [];
  List monthData = [];
  List monthData1 = [];
  List monthData2 = [];
  List monthData3 = [];

  //------------------ WEIGHT GRAPH------------------//

  Future<void> fetchWeight() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('id');
    QuerySnapshot weightSnapshot = await FirebaseFirestore.instance
        .collection('weight')
      
        .where('pet_id', isEqualTo: widget.pet_id)
        .get();

    setState(() {
      // Map weight and month data
      weightData = weightSnapshot.docs.map((doc) => doc['weight']).toList();
      monthData = weightSnapshot.docs.map((doc) => doc['month']).toList();

      // Convert month names to numerical values
      Map<String, int> monthMap = {
        'January': 1,
        'February': 2,
        'March': 3,
        'April': 4,
        'May.': 5,
        'June': 6,
        'July': 7,
        'August': 8,
        'September': 9,
        'October': 10,
        'November': 11,
        'December': 12,
      };

      // Sort both weightData and monthData based on the numerical month values
      for (int i = 0; i < monthData.length - 1; i++) {
        for (int j = i + 1; j < monthData.length; j++) {
          int? monthValueI = monthMap[monthData[i]];
          int? monthValueJ = monthMap[monthData[j]];

          if (monthValueI != null && monthValueJ != null) {
            if (monthValueI > monthValueJ) {
              // Swap weights
              var tempWeight = weightData[i];
              weightData[i] = weightData[j];
              weightData[j] = tempWeight;

              // Swap months
              var tempMonth = monthData[i];
              monthData[i] = monthData[j];
              monthData[j] = tempMonth;
            }
          }
        }
      }
    });

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fetchHeight() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('id');
    QuerySnapshot heightSnapshot = await FirebaseFirestore.instance
        .collection('height')
      
        .where('pet_id', isEqualTo: widget.pet_id)
        .get();

    setState(() {
      // Map weight and month data
      heightData = heightSnapshot.docs.map((doc) => doc['height']).toList();
      monthData1 = heightSnapshot.docs.map((doc) => doc['month']).toList();

      // Convert month names to numerical values
      Map<String, int> monthMap1 = {
        'January': 1,
        'February': 2,
        'March': 3,
        'April': 4,
        'May': 5,
        'June': 6,
        'July': 7,
        'August': 8,
        'September': 9,
        'October': 10,
        'November': 11,
        'December': 12,
      };

      // Sort both weightData and monthData based on the numerical month values
      for (int i = 0; i < monthData1.length - 1; i++) {
        for (int j = i + 1; j < monthData1.length; j++) {
          int? monthValueI = monthMap1[monthData1[i]];
          int? monthValueJ = monthMap1[monthData1[j]];

          if (monthValueI != null && monthValueJ != null) {
            if (monthValueI > monthValueJ) {
              // Swap weights
              var tempHeight = heightData[i];
              heightData[i] = heightData[j];
              heightData[j] = tempHeight;

              // Swap months
              var tempMonth = monthData1[i];
              monthData1[i] = monthData1[j];
              monthData1[j] = tempMonth;
            }
          }
        }
      }
    });

    if (mounted) {
      setState(() {});
    }
  }


 Future<void> fetchHr() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('id');
    QuerySnapshot hrSnapshot = await FirebaseFirestore.instance
        .collection('hr')
       
        .where('pet_id', isEqualTo: widget.pet_id)
        .get();

    setState(() {
      // Map weight and month data
      hrData =hrSnapshot.docs.map((doc) => doc['hr']).toList();
      monthData3 = hrSnapshot.docs.map((doc) => doc['month']).toList();

      // Convert month names to numerical values
      Map<String, int> monthMap3 = {
        'January': 1,
        'February': 2,
        'March': 3,
        'April': 4,
        'May': 5,
        'June': 6,
        'July': 7,
        'August': 8,
        'September': 9,
        'October': 10,
        'November': 11,
        'December': 12,
      };

      // Sort both weightData and monthData based on the numerical month values
      for (int i = 0; i < monthData3.length - 1; i++) {
        for (int j = i + 1; j < monthData3.length; j++) {
          int? monthValueI = monthMap3[monthData3[i]];
          int? monthValueJ = monthMap3[monthData3[j]];

          if (monthValueI != null && monthValueJ != null) {
            if (monthValueI > monthValueJ) {
              // Swap weights
              var tempHr = hrData[i];
              hrData[i] = hrData[j];
              hrData[j] = tempHr;

              // Swap months
              var tempMonth = monthData3[i];
              monthData3[i] = monthData3[j];
              monthData3[j] = tempMonth;
            }
          }
        }
      }
    });

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fetchBp() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('id');
    QuerySnapshot bpSnapshot = await FirebaseFirestore.instance
        .collection('bp')
      
        .where('pet_id', isEqualTo: widget.pet_id)
        .get();

    setState(() {
      // Map weight and month data
      bpData = bpSnapshot.docs.map((doc) => doc['bp']).toList();
      monthData2 = bpSnapshot.docs.map((doc) => doc['month']).toList();

      // Convert month names to numerical values
      Map<String, int> monthMap2 = {
        'January': 1,
        'February': 2,
        'March': 3,
        'April': 4,
        'May.': 5,
        'June': 6,
        'July': 7,
        'August': 8,
        'September': 9,
        'October': 10,
        'November': 11,
        'December': 12,
      };

      // Sort both weightData and monthData based on the numerical month values
      for (int i = 0; i < monthData2.length - 1; i++) {
        for (int j = i + 1; j < monthData2.length; j++) {
          int? monthValueI = monthMap2[monthData2[i]];
          int? monthValueJ = monthMap2[monthData2[j]];

          if (monthValueI != null && monthValueJ != null) {
            if (monthValueI > monthValueJ) {
              // Swap weights
              var tempBp = bpData[i];
              bpData[i] = bpData[j];
              bpData[j] = tempBp;

              // Swap months
              var tempMonth = monthData2[i];
              monthData2[i] = monthData2[j];
              monthData2[j] = tempMonth;
            }
          }
        }
      }
    });

    if (mounted) {
      setState(() {});
    }
  }
  //------------------END OF WEIGHT GRAPH------------------//

  //------------------PET VIEW------------------//
  Future<void> getData() async {
    try {
      DocumentSnapshot petSnapshot = await FirebaseFirestore.instance
          .collection('petlist')
          .doc(widget.pet_id)
          .get();

      if (petSnapshot.exists) {
        setState(() {
          petName = petSnapshot['name'];
          age = petSnapshot['age'];
          image = petSnapshot['image'];
          isLoading = false; // Data loading is complete
        });
      } else {
        // Handle case where the pet with the specified ID doesn't exist
        print('Pet not found');
        setState(() {
          petName = 'Not Found';
          age = 'Not Found';
          isLoading = false; // Data loading is complete
        });
      }
    } catch (error) {
      print('Error retrieving pet data: $error');
      setState(() {
        petName = 'Error';
        age = 'Error';
        isLoading = false; // Data loading is complete
      });
    }
  }
  //------------------END PET VIEW------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : image != null
                            ? Image.network(image!, fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                return Text('Image Load Failed');
                              })
                            : Text('No Image'),
                    color: Colors.amber,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoading)
                      CircularProgressIndicator()
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: $petName'),
                          Text('Age: $age'),
                        ],
                      ),
                  ],
                )
              ],
            ),

            // ----------------WEIGHT GRAPH--------------//
            Text('Weight Data'),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: [
                    SfSparkLineChart(
                      trackball: SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap,
                      ),
                      marker: SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all,
                      ),
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      data: weightData.isNotEmpty && monthData.isNotEmpty
                          ? List.generate(weightData.length, (index) {
                              // Ensure index is within valid range
                              if (index >= 0 && index < monthData.length) {
                                return double.parse(
                                    weightData[index].toString());
                              } else {
                                return 0.0; // Provide a default value if index is out of range
                              }
                            })
                          : [
                              0.0
                            ], // Provide a default value if either list is empty
                    ),
                    SizedBox(height: 10),
                    Text('Weight and Month Data'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          weightData.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  ' ${weightData[index]}Kg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${monthData[index].substring(0, 3)}'),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -------------UPDATE BUTTON-----------------//
          
            Text('Height Data'),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: [
                    SfSparkLineChart(
                      trackball: SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap,
                      ),
                      marker: SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all,
                      ),
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      data: weightData.isNotEmpty && monthData1.isNotEmpty
                          ? List.generate(heightData.length, (index) {
                              // Ensure index is within valid range
                              if (index >= 0 && index < monthData1.length) {
                                return double.parse(
                                    heightData[index].toString());
                              } else {
                                return 0.0; // Provide a default value if index is out of range
                              }
                            })
                          : [
                              0.0
                            ], // Provide a default value if either list is empty
                    ),
                    SizedBox(height: 10),
                    Text('Height and Month Data'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          heightData.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  ' ${heightData[index]}Kg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${monthData1[index].substring(0, 3)}'),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -------------UPDATE BUTTON-----------------//
           
            Text('Bp Data'),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: [
                    SfSparkLineChart(
                      trackball: SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap,
                      ),
                      marker: SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all,
                      ),
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      data: bpData.isNotEmpty && monthData2.isNotEmpty
                          ? List.generate(bpData.length, (index) {
                              // Ensure index is within valid range
                              if (index >= 0 && index < monthData2.length) {
                                return double.parse(bpData[index].toString());
                              } else {
                                return 0.0; // Provide a default value if index is out of range
                              }
                            })
                          : [
                              0.0
                            ], // Provide a default value if either list is empty
                    ),
                    SizedBox(height: 10),
                    Text('Bp and Month Data'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          bpData.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  ' ${bpData[index]}Kg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${monthData2[index].substring(0, 3)}'),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -------------UPDATE BUTTON-----------------//
           
             Text('HeartRate Data'),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: [
                    SfSparkLineChart(
                      trackball: SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap,
                      ),
                      marker: SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all,
                      ),
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      data: hrData.isNotEmpty && monthData3.isNotEmpty
                          ? List.generate(hrData.length, (index) {
                              // Ensure index is within valid range
                              if (index >= 0 && index < monthData3.length) {
                                return double.parse(hrData[index].toString());
                              } else {
                                return 0.0; // Provide a default value if index is out of range
                              }
                            })
                          : [
                              0.0
                            ], // Provide a default value if either list is empty
                    ),
                    SizedBox(height: 10),
                    Text('HeartRate and Month Data'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          hrData.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  ' ${hrData[index]}Kg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${monthData3[index].substring(0, 3)}'),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -------------UPDATE BUTTON-----------------//
         
          ],
        ),
      ),
    );
  }
}
