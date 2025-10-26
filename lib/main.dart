import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Mehvesujood/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        primaryColor: Colors.black,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.dark(
          background: Colors.black, // <-- underlay fallback color
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => splash_screen()},
    ),
  );
}
