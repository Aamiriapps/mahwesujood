import 'package:Mehvesujood/TrackClassUrdu.dart';
import 'package:Mehvesujood/kalam/urdu/ishq/ishqlist.dart';
import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
import 'package:Mehvesujood/kalam/urdu/noori/noori_list.dart';
import 'package:Mehvesujood/kalam/urdu/parsi/parsi_list.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class urdupage extends StatelessWidget {
  const urdupage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'اردو',
          style: GoogleFonts.notoNastaliqUrdu(
            color: Colors.white,
            fontSize: 30,
          ),
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
                              'assets/Naatein.png',
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
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/IshqoMarifat.png',
                              //fit: BoxFit.fill,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IshqList(),
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
                              'assets/QindeParsi.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParsiList(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/ManaqibeNoori.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NooriListUrdu(),
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
                              'assets/NaghmayeSarmadi.png',
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
                                            'kalam/naghmaye_sarmadi/',
                                        imageAsset:
                                            'assets/arabi_title/urdu/2.png',
                                        artistPaths: {
                                          'Danish': 'kalam/Audios/Danish/Sarmadi/1.mp3',
                                        },
                                        appBarTitle: 'Naghme-e-Sarmadi',
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          // child:  Image.asset('assets/arabic.png'),
                          child: new GestureDetector(
                            child: Image.asset(
                              'assets/KalameArabi.png',
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => TrackPlayerScreen(
                                        title: 'AL MANAJATH',
                                        firebaseImagePath: 'kalam/Al_Manajath/',
                                        imageAsset:
                                            'assets/arabi_title/urdu/1.png',
                                        artistPaths: {},
                                        appBarTitle: 'Kalaam e Arabi',
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
                                'assets/Salaam.png',
                                width: 140,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TrackPlayerScreen(
                                          title: 'SALAMUN MALAHU ADAD',
                                          firebaseImagePath: 'kalam/Salaam',
                                          imageAsset:
                                              'assets/salaam_title/Salam.png',
                                          artistPaths: {},
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
