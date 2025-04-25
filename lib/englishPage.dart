
import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/ishqlistEnglish.dart';

import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/urdupage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Englishpage extends StatefulWidget {
  const Englishpage({super.key});

  @override
  State<Englishpage> createState() => _EnglishpageState();
}

class _EnglishpageState extends State<Englishpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'English',
          style: GoogleFonts.robotoCondensed(color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade900,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.brown.shade900,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/eng_button/2.png',
                             
                              // fit: BoxFit.fill,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Naat_list(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/eng_button/1.png',
                              //fit: BoxFit.fill,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IshqListEnglish(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/eng_button/5.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => urdupage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/eng_button/3.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => urdupage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/eng_button/4.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => TrackPlayerScreen(
                                        title: 'NAGHMA-E-SARMADI',
                                        firebaseImagePath:
                                            'kalam/English/Naghma_e_sarmadi',
                                        imageAsset:
                                            'assets/arabi_title/Al_Manajath.png',
                                        artistPaths: {
                                          'Danish':
                                              'kalam/Audios/Danish/Ishq/1.mp3',
                                          'Imran':
                                              'kalam/Audios/Imran/Ishq/1.mp3',
                                          'Arif':
                                              'kalam/Audios/Arif/Ishq/1.mp3',
                                        },
                                        appBarTitle: 'Naghme-e-Sarmadi',
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/eng_button/6.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => TrackPlayerScreen(
                                        title: 'AL MANAJATH',
                                        firebaseImagePath: 'kalam/Al_Manajath',
                                        imageAsset:
                                            'assets/arabi_title/Al_Manajath.png',
                                        artistPaths: {
                                          'Danish':
                                              'kalam/Audios/Danish/Ishq/1.mp3',
                                          'Imran':
                                              'kalam/Audios/Imran/Ishq/1.mp3',
                                          'Arif':
                                              'kalam/Audios/Arif/Ishq/1.mp3',
                                        },
                                        appBarTitle: 'Arabi Kalaam',
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            // child:  Image.asset('assets/arabic.png'),
                            child: new GestureDetector(
                              child: Image.asset(
                                'assets/eng_button/7.png',
                                width: 140,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TrackPlayerScreen(
                                          title: 'SALAMUN MALAHU ADAD',
                                          firebaseImagePath: 'kalam/English/Salaam',
                                          imageAsset:
                                              'assets/salaam_title/Salam.png',
                                          artistPaths: {
                                            'Danish':
                                                'kalam/Audios/Danish/Ishq/1.mp3',
                                            'Imran':
                                                'kalam/Audios/Imran/Ishq/1.mp3',
                                            'Arif':
                                                'kalam/Audios/Arif/Ishq/1.mp3',
                                          },
                                          appBarTitle: 'Salaam',
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
