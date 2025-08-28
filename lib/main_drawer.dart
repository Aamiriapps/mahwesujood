import 'dart:io';

import 'package:Mehvesujood/PeerAamirKaleemi.dart';

import 'package:Mehvesujood/about_us.dart';
import 'package:Mehvesujood/englishPage.dart';
import 'package:Mehvesujood/urdupage.dart';
import 'package:Mehvesujood/urdutest.dart';
import 'package:Mehvesujood/urdutest2.dart';
import 'package:Mehvesujood/urdutest4.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_redirect/store_redirect.dart';

import 'dashborad.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF2F2005), Color(0xFF92772C), Color(0xFF2F2005)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          margin: EdgeInsets.only(bottom: 0.0),
          //color: Colors.brown[900],
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              ListTile(
                title: Text(
                  'Mehwe Sujood',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(fontSize: 22, color: Colors.white),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: null,
              ),

              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Home',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Test2',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TrackPlayerScreen4(
                            title: 'سیر فی الوجود',
                            nazam: 'assets/75.txt',
                            //   imageAsset: 'assets/arabi_title/urdu/1.png',
                            artistPaths: {
                              'Danish': 'audio/75.mp3',
                              'Imran': 'audio/75.mp3',
                            },
                            appBarTitle: 'ISHQ-O-MARIFAT',
                          ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Test4',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TrackPlayerScreen(
                            title: 'AL MANAJATH',
                            imageAsset: 'assets/arabi_title/urdu/1.png',
                            artistPaths: {'Danish': 'assets/ALLAHU.mp3'},
                            appBarTitle: 'ISHQ-O-MARIFAT',
                          ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Test',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TrackPlayerScreen2(
                            title: 'AL MANAJATH',
                            imageAsset: 'assets/arabi_title/urdu/1.png',
                            artistPaths: {'Danish': 'assets/audio/75.mp3'},
                            appBarTitle: 'ISHQ-O-MARIFAT',
                          ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.auto_awesome, color: Colors.white),
                title: Text(
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:3529432756.
                  'About Peer Aamir Kaleemi',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeerAamirKaleemiScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book_outlined, color: Colors.white),
                title: Text(
                  'Urdu Section',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UrduPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book_rounded, color: Colors.white),
                title: Text(
                  'English Section',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Englishpage()),
                  );
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.install_mobile_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  'Install Allahu App',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  StoreRedirect.redirect(androidAppId: 'com.habibi.asmulhusna');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.install_mobile_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  'Install Darood-e-Aamir Kaleemi App',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  StoreRedirect.redirect(
                    androidAppId: 'com.habibi.daroodeaamiri',
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.info_outline, color: Colors.white),
                title: Text(
                  'About Us',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text(
                  'Exit',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  exit(0);
                },
              ),
              SizedBox(height: 600.0),
            ],
          ),
        ),
      ),
    );
  }
}
