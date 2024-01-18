import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_new/User/graph/petView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateHeight extends StatefulWidget {
  String pet_id;
  UpdateHeight({super.key, required this.pet_id});

  @override
  State<UpdateHeight> createState() => _UpdateHeightState();
}

class _UpdateHeightState extends State<UpdateHeight> {
  final _formKey = GlobalKey<FormState>();
  String? selectedMonth;
  var height = TextEditingController();

  @override
  void dispose() {
    height.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue;
                  });
                },
                items: <String>[
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
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select Month',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: height,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Height',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the height.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: () async {
                  print('----------------start--------------');
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      // Add a loading indicator or feedback here if necessary

                      SharedPreferences spref =
                          await SharedPreferences.getInstance();
                      var sp = spref.getString('id');
                      await FirebaseFirestore.instance.collection('height').add({
                        'user_id': sp,
                        'pet_id': widget.pet_id,
                        'month': selectedMonth,
                        'height': height.text,
                      });

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return PetView(pet_id: widget.pet_id);
                        }));

                      // Remove loading indicator or provide success feedback

                      // Perform the save action
                      // For example, you can navigate back to the previous screen
                      // Navigator.pop(context);
                    } catch (error) {
                      // Handle Firestore operation errors
                      print('Firestore Error: $error');
                      // Provide error feedback to the user
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
