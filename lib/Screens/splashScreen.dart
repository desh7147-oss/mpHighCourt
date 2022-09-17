import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hcabaj/Screens/HomeScreen.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    super.initState();
    performTheRedirection();
  }

  void performTheRedirection() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    int? isLoggedIn = shared.getInt(("isLoggedIn"));
    if (isLoggedIn != null && isLoggedIn == 1) {
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false));
    } else {
      Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(backGroundColor),
      child: Center(
        child: Image.asset("lib/assets/HCABAJ-removebg-preview.png",
            height: 180.0, width: 300, fit: BoxFit.fitWidth),
      ),
    );
  }
}
