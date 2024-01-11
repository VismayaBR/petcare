import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPetUpdates extends StatefulWidget {
  String pet_id;
  AddPetUpdates({Key? key, required this.pet_id}) : super(key: key);

  @override
  State<AddPetUpdates> createState() => _AddPetUpdatesState();
}

class _AddPetUpdatesState extends State<AddPetUpdates> {
  var petName = "Loading..."; // Initial placeholder value
  var age = "Loading..."; // Initial placeholder value
  bool isLoading = true;
  var image; // Flag to track whether data is being loaded

  @override
  void initState() {
    super.initState();
    getData();
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
          print('/////////////$image');
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
    appBar: AppBar(
      title: Text('Pet Details'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
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
                            ? Image.network(image, fit: BoxFit.cover, errorBuilder:
                                (BuildContext context, Object error,
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
            SizedBox(height: 20), // Add spacing between the pet details and the TextFormField
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Month : '),
                Container(
                  color: Color.fromARGB(255, 243, 230, 226),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter some text...',
                      border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10), 
                    ),
                  ),
                ),
                Text('Height : '),
                Container(
                  color: Color.fromARGB(255, 243, 230, 226),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter some text...',
                      
                      border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10), 
                    ),
                  ),
                ),
                 Text('Weight : '),
                Container(
                  color: Color.fromARGB(255, 243, 230, 226),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter some text...',
                      
                      border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10), 
                    ),
                  ),
                ),
                 Text('HeartRate : '),
                Container(
                  color: Color.fromARGB(255, 243, 230, 226),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter some text...',
                      
                      border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10), 
                    ),
                  ),
                ),
                 Text('Bp : '),
                Container(
                  color: Color.fromARGB(255, 243, 230, 226),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter some text...',
                      
                      border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10), 
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  width: double.infinity,
                  height: 40,child: Center(child: Text('Update')),
                  color: Color.fromARGB(255, 179, 150, 139),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
  }
}
