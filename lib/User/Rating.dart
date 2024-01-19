import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:petcare_new/User/NavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rating extends StatefulWidget {
  String did;
   Rating({super.key, required this.did});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rating = 3.0; // Default rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Doctor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            SizedBox(height: 20),
            Text(
              'Rate the doctor',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences spref = await SharedPreferences.getInstance();
                var sp = spref.getString('id');
                FirebaseFirestore.instance.collection('rating')
                .add({
                  'doctor_id':widget.did,
                  'rating':rating,
                  'user_id':sp
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                  return Navigation();
                }));
                // TODO: Perform actions when the user submits the rating
                // You can save the rating to the database or perform other tasks
                print('Submitted rating: $rating');
              },
              child: Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }
}