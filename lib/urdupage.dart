/* import 'package:Mehvesujood/TrackClassUrdu.dart';
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
 */
/*  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/TrackClassUrdu.dart';
import 'package:Mehvesujood/kalam/urdu/ishq/ishqlist.dart';
import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
import 'package:Mehvesujood/kalam/urdu/noori/noori_list.dart';
import 'package:Mehvesujood/kalam/urdu/parsi/parsi_list.dart';

class UrduPage extends StatelessWidget {
  const UrduPage({Key? key}) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildButtonRow(
                context,
                'assets/Naatein.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Naat_list()),
                ),
                'assets/IshqoMarifat.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => IshqList()),
                ),
              ),
              SizedBox(height: 16),
              _buildButtonRow(
                context,
                'assets/QindeParsi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ParsiList()),
                ),
                'assets/ManaqibeNoori.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NooriListUrdu()),
                ),
              ),
              SizedBox(height: 16),
              _buildButtonRow(
                context,
                'assets/NaghmayeSarmadi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'NAGHMA-E-SARMADI',
                          firebaseImagePath: 'kalam/naghmaye_sarmadi/',
                          imageAsset: 'assets/arabi_title/urdu/2.png',
                          artistPaths: {
                            'Danish': 'kalam/Audios/Danish/Sarmadi/1.mp3',
                          },
                          appBarTitle: 'نغمہ سرمدی',
                        ),
                  ),
                ),
                'assets/KalameArabi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'AL MANAJATH',
                          firebaseImagePath: 'kalam/Al_Manajath/',
                          imageAsset: 'assets/arabi_title/urdu/1.png',
                          artistPaths: {},
                          appBarTitle: 'کلامِ عربی',
                        ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Single centered Salaam button
              Row(
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: _buildSingleButton(
                      context,
                      'assets/Salaam.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TrackPlayerScreen(
                                title: 'SALAMUN MALAHU ADAD',
                                firebaseImagePath: 'kalam/Salaam',
                                imageAsset: 'assets/salaam_title/Salam.png',
                                artistPaths: {},
                                appBarTitle: 'سلام',
                              ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(
    BuildContext context,
    String asset1,
    VoidCallback onTap1,
    String asset2,
    VoidCallback onTap2,
  ) {
    return Row(
      children: [
        Expanded(child: _buildSingleButton(context, asset1, onTap1)),
        SizedBox(width: 16),
        Expanded(child: _buildSingleButton(context, asset2, onTap2)),
      ],
    );
  }

  Widget _buildSingleButton(
    BuildContext context,
    String assetPath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1, // Square button
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }
}
 
 */
/* 
import 'dart:ui'; // <--- IMPORTANT for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/TrackClassUrdu.dart';
import 'package:Mehvesujood/kalam/urdu/ishq/ishqlist.dart';
import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
import 'package:Mehvesujood/kalam/urdu/noori/noori_list.dart';
import 'package:Mehvesujood/kalam/urdu/parsi/parsi_list.dart';

class UrduPage extends StatelessWidget {
  const UrduPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // << VERY IMPORTANT
      backgroundColor: Colors.brown.shade900,
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
          'اردو',
          style: GoogleFonts.notoNastaliqUrdu(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: kToolbarHeight + 16, // Push content BELOW the AppBar
            left: 25,
            right: 25,
            bottom: 16,
          ),
          child: Column(
            children: [
              _buildButtonRow(
                context,
                'assets/Naatein.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Naat_list()),
                ),
                'assets/IshqoMarifat.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => IshqList()),
                ),
              ),
            //  const SizedBox(height: 16),
              _buildButtonRow(
                context,
                'assets/QindeParsi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ParsiList()),
                ),
                'assets/ManaqibeNoori.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NooriListUrdu()),
                ),
              ),
             // const SizedBox(height: 16),
              _buildButtonRow(
                context,
                'assets/NaghmayeSarmadi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'NAGHMA-E-SARMADI',
                          firebaseImagePath: 'kalam/naghmaye_sarmadi/',
                          imageAsset: 'assets/arabi_title/urdu/2.png',
                          artistPaths: {
                            'Danish': 'kalam/Audios/Danish/Sarmadi/1.mp3',
                          },
                          appBarTitle: 'Naghma-e-Sarmadi',
                        ),
                  ),
                ),
                'assets/KalameArabi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'AL MANAJATH',
                          firebaseImagePath: 'kalam/Al_Manajath/',
                          imageAsset: 'assets/arabi_title/urdu/1.png',
                          artistPaths: {},
                          appBarTitle: 'Kalaam-e-Arabi',
                        ),
                  ),
                ),
              ),
            //  const SizedBox(height: 16),
              // Single centered Salaam button
              Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: _buildSingleButton(
                      context,
                      'assets/Salaam.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TrackPlayerScreen(
                                title: 'SALAMUN MALAHU ADAD',
                                firebaseImagePath: 'kalam/Salaam',
                                imageAsset: 'assets/salaam_title/Salam.png',
                                artistPaths: {},
                                appBarTitle: 'Salaam',
                              ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(
    BuildContext context,
    String asset1,
    VoidCallback onTap1,
    String asset2,
    VoidCallback onTap2,
  ) {
    return Row(
      children: [
        Expanded(child: _buildSingleButton(context, asset1, onTap1)),
        // const SizedBox(width: 8),
        Expanded(child: _buildSingleButton(context, asset2, onTap2)),
      ],
    );
  }

  Widget _buildSingleButton(
    BuildContext context,
    String assetPath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Transform.scale(
          scale: 0.75, // Shrinks the image to 75% (i.e., 25% smaller)
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
 */

import 'dart:ui'; // <--- IMPORTANT for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/TrackClassUrdu.dart';
import 'package:Mehvesujood/kalam/urdu/ishq/ishqlist.dart';
import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
import 'package:Mehvesujood/kalam/urdu/noori/noori_list.dart';
import 'package:Mehvesujood/kalam/urdu/parsi/parsi_list.dart';

class UrduPage extends StatelessWidget {
  const UrduPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // << VERY IMPORTANT
      backgroundColor: Colors.brown.shade900,
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
          'اردو',
          style: GoogleFonts.notoNastaliqUrdu(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: kToolbarHeight + 16, // Push content BELOW the AppBar
            left: 25,
            right: 25,
            bottom: 16,
          ),
          child: Column(
            children: [
              _buildButtonRow(
                context,
                'assets/Naatein.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Naat_list()),
                ),
                'assets/IshqoMarifat.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => IshqList()),
                ),
              ),

              _buildButtonRow(
                context,
                'assets/QindeParsi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ParsiList()),
                ),
                'assets/ManaqibeNoori.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NooriListUrdu()),
                ),
              ),

              _buildButtonRow(
                context,
                'assets/NaghmayeSarmadi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'NAGHMA-E-SARMADI',
                          firebaseImagePath: 'kalam/naghmaye_sarmadi/',
                          imageAsset: 'assets/arabi_title/urdu/2.png',
                          artistPaths: {
                            'Danish': 'kalam/Audios/Danish/Sarmadi/1.mp3',
                          },
                          appBarTitle: 'Naghma-e-Sarmadi',
                        ),
                  ),
                ),
                'assets/KalameArabi.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'AL MANAJATH',
                          firebaseImagePath: 'kalam/Al_Manajath/',
                          imageAsset: 'assets/arabi_title/urdu/1.png',
                          artistPaths: {},
                          appBarTitle: 'Kalaam-e-Arabi',
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Single centered Salaam button
              Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: _buildSingleButton(
                      context,
                      'assets/Salaam.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TrackPlayerScreen(
                                title: 'SALAMUN MALAHU ADAD',
                                firebaseImagePath: 'kalam/Salaam',
                                imageAsset: 'assets/salaam_title/Salam.png',
                                artistPaths: {
                                  'Danish': 'kalam/Audios/Danish/salaam/1.mp3',
                                },
                                appBarTitle: 'Salaam',
                              ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(
    BuildContext context,
    String asset1,
    VoidCallback onTap1,
    String asset2,
    VoidCallback onTap2,
  ) {
    return Row(
      children: [
        Expanded(child: _buildSingleButton(context, asset1, onTap1)),
        // const SizedBox(width: 8),
        Expanded(child: _buildSingleButton(context, asset2, onTap2)),
      ],
    );
  }

  Widget _buildSingleButton(
    BuildContext context,
    String assetPath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Transform.scale(
          scale:
              0.85, // Shrink the image slightly to make the buttons more compact
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
