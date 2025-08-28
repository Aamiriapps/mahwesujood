import 'dart:async';

import 'package:Mehvesujood/splash_screen/splash_screen1.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class splash_screen extends StatefulWidget {
  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  void completed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SplashScreenOne()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), completed);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    //Colors.brown.shade900,
                    Color(0xFF92772C),
                    Color(0xFF2F2005),

                    //Color(0xFF2F2005),
                  ],
                  radius: 0.9,
                ),
                /* image: DecorationImage(
                    image: AssetImage("assets/splashscreen.png"),
                    fit: BoxFit.fill,
                  ), */
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mehwe Sujood',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(child: Image.asset("assets/g14636.png", width: 100)),
                  // SizedBox(height: 300),
                ],
              ),
              /* add child content here */
            ),
          ),
        ],
      ),
    );
  }
}
