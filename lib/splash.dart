import 'dart:async';
import 'package:flutter/material.dart';
import 'package:petcare_new/login.dart';

class Splash_ extends StatefulWidget {
  const Splash_({super.key});

  @override
  State<Splash_> createState() => _Splash_State();
}

class _Splash_State extends State<Splash_> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>const Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                child: Image.asset("asset/Screenshot.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
