import 'dart:io';
import 'package:Mehvesujood/englishPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/urdupage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();

    // Lock to portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent auto pop
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final shouldExit = await showExitPopup(context);
        if (shouldExit) {
          _exitApp();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.brown[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Select Language',
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.brown.shade900,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: MainDrawer(),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    'Diwaan of Shamasul Mufassireen Faridul Asr Allama Alhaaj Syed Muhammed Omer Aamir Kaleemi Shah Hasni-Ul-Hussaini Jafari-Ul-Jeelani Chishti Qadri Noori Khwaja Faqeer Nawaz (رحمة الله عليه)',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                  child: Text(
                    '30th Great Grand son of Peeran e Peer Roshan Zameer Sarkar Ghousul Aazam Shaik Abdul Qhadir Jeelani Qaddas Allah sirrahu alazeez (رحمة الله عليه)',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const urdupage()),
                    );
                  },
                  child: Image.asset('assets/arabic.png', width: 250),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Englishpage()),
                    );
                  },
                  child: Image.asset('assets/english.png', width: 250),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _exitApp() {
    if (kIsWeb) return; // Can't exit web
    if (Platform.isAndroid || Platform.isIOS) {
      SystemNavigator.pop(); // Mobile exit
    } else {
      exit(0); // Desktop
    }
  }
}

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.brown.shade800,
            title: const Text('Warning', style: TextStyle(color: Colors.white)),
            content: const Text(
              'Are you sure you want to exit?',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          );
        },
      ) ??
      false;
}
