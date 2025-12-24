import 'dart:async';

import 'package:flutter/material.dart';

class ContactSplashScreen extends StatefulWidget {
  @override
  State<ContactSplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<ContactSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'contact_home_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF29384D),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/Group 6.png",
                  width: 250,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
