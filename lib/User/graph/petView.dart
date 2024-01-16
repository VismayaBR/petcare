import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_new/User/graph/UpdateWeight.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PetView extends StatefulWidget {
  String pet_id;
  PetView({Key? key, required this.pet_id}) : super(key: key);

  @override
  State<PetView> createState() => _PetViewState();
}

class _PetViewState extends State<PetView> {
  var petName = "Loading..."; // Initial placeholder value
  var age = "Loading..."; // Initial placeholder value
  bool isLoading = true;
  var image; // Flag to track whether data is being loaded

  @override
  void initState() {
    super.initState();
    getData();
    fetchWeight();
  }

  List weightData = [];
  List monthData = [];

  Future<void> fetchWeight() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('id');
    QuerySnapshot weightSnapshot = await FirebaseFirestore.instance
        .collection('weight')
        .where('user_id', isEqualTo: sp)
        .where('pet_id', isEqualTo: widget.pet_id)
        .get();

    setState(() {
      weightData = weightSnapshot.docs.map((doc) => doc['weight']).toList();
      monthData = weightSnapshot.docs.map((doc) => doc['month']).toList();
    });

    // After fetching weight data, call the build method to rebuild the widget
    if (mounted) {
      setState(() {});
    }
  }

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
                            ? Image.network(image!,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context, Object error,
                                    StackTrace? stackTrace) {
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
                      data: weightData
                          .map<double>((weight) => double.parse(weight.toString()))
                          .toList(),
                    ),
                    SizedBox(height: 10),
                    Text('Weight and Month Data'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          weightData.length,
                          (index) => Column(
                            children: [
                              Text(
                                ' ${weightData[index]}Kg',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${monthData[index]}'),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return UpdateWeight(pet_id: widget.pet_id);
                      }));
                    },
                    child: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}