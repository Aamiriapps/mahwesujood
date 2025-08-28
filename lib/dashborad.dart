/* import 'dart:io';
import 'package:Mehvesujood/englishPage.dart';
import 'package:Mehvesujood/urdupage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';

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
                /*  Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    'Diwaan of Shamasul Mufassireen Faridul Asr Allama Alhaaj Syed Muhammed Omer Aamir Kaleemi Shah Hasni-Ul-Hussaini Jafari-Ul-Jeelani Chishti Qadri Noori Khwaja Faqeer Nawaz (RA)',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 40),
                  child: Text(
                    '30th Great Grand son of Peeran e Peer Roshan Zameer Sarkar Ghousul Aazam Shaik Abdul Qhadir Jeelani Qaddas Allah sirrahu alazeez (RA)',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),*/
                GlossyEmbossedUrduButton(
                  text: 'اردو',
                  onPressed: () {
                    // Your actionNavigator.push(
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UrduPage()),
                    );
                  },
                ),
                /* GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UrduPage()),
                    );
                  },
                  child: Image.asset('assets/arabic.png', width: 250),
                ), */
                const SizedBox(height: 40),
                GlossyEmbossedButton(
                  text: 'English',
                  onPressed: () {
                    // Your actionNavigator.push(
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Englishpage()),
                    );
                  },
                ),
                /* GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Englishpage()),
                    );
                  },
                  child: Image.asset('assets/english.png', width: 250),
                ), */
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

class GlossyEmbossedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GlossyEmbossedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.shade900, width: 2),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFDD0), Color(0xFFFFF8DC), Color(0xFFFFF5E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            // Outer soft shadow
            BoxShadow(
              color: Colors.brown.shade300,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
            // Simulated inner shadow (for embossed look)
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.robotoCondensed(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade900,
              shadows: const [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  color: Colors.white, // Gives text a soft raised look
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlossyEmbossedUrduButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GlossyEmbossedUrduButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.shade900, width: 2),
          gradient: const LinearGradient(
            //Color(0xFFFFFDD0), Color(0xFFFFF8DC), Color(0xFFFFF5E1)
            //Color(0xFFFFFFFF), Color(0xFFF6F6F6), Color(0xFFEFEFEF)
            colors: [Color(0xFFFFFDD0), Color(0xFFFFF8DC), Color(0xFFFFF5E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            // Outer soft shadow
            BoxShadow(
              color: Colors.brown.shade300,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
            // Simulated inner shadow (for embossed look)
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.notoNastaliqUrdu(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade900,
              shadows: const [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  color: Colors.white, // Gives text a soft raised look
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Glossy3DCreamButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Glossy3DCreamButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 220,
        height: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFF5DC), // Top - lighter cream
              Color(0xFFFFEFC1), // Bottom - richer cream
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade700.withOpacity(0.6),
              offset: const Offset(5, 5),
              blurRadius: 15,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A2C04), // Deep brown text
            ),
          ),
        ),
      ),
    );
  }
}
 */

import 'dart:io';
import 'dart:ui';
import 'package:Mehvesujood/englishPage.dart';
import 'package:Mehvesujood/urdupage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';

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
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final shouldExit = await showExitPopup(context);
        if (shouldExit) {
          _exitApp();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: MainDrawer(),
        appBar: AppBar(
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Select Language',
            style: GoogleFonts.cormorantGaramond(
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),

          /* gradient: RadialGradient(
              colors: [Colors.brown, Colors.black],
              radius: 0.8,
              center: Alignment.center,
            ), */
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UrduPage()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2, // Border width
                        ),
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2F2005),
                            Color(0xFF92772C),
                            Color(0xFF2F2005),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'اردو',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Nastaleeq',
                            fontSize: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    //Image.asset('assets/urdu.png', width: 150),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Englishpage()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2, // Border width
                        ),
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2F2005),
                            Color(0xFF92772C),
                            Color(0xFF2F2005),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'English',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cormorantGaramond(
                            fontWeight: FontWeight.w700,
                            textStyle: const TextStyle(color: Colors.white),
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),

                    //Image.asset('assets/english.png', width: 150),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _exitApp() {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
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
