import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Mehvesujood/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => splash_screen()},
    ),
  );
}
