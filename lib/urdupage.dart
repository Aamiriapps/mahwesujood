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
import 'package:Mehvesujood/kalam/urdu/arabi/arabi_list.dart';
import 'package:Mehvesujood/kalam/urdu/salaam/salaam_list.dart';
import 'package:Mehvesujood/kalam/urdu/sarmadi/sarmadi_list.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
//import 'package:Mehvesujood/TrackClassUrdu.dart';
import 'package:Mehvesujood/kalam/urdu/ishq/ishqlist.dart';
import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
//import 'package:Mehvesujood/kalam/urdu/noori/noori_list.dart';
//import 'package:Mehvesujood/kalam/urdu/parsi/parsi_list.dart';

/* 
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
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontFamily: 'Nastaleeq',
            fontSize: 35,
            color: Colors.white,
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
              Container(
                //height: 100,
                // width: 150,
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
                    'Ishq-o-Marifat Pandh-o-Muzath',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoCondensed(
                      textStyle: const TextStyle(color: Colors.white),
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
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
 */
class UrduPage extends StatelessWidget {
  const UrduPage({Key? key}) : super(key: key);

  // Reusable button builder
  Widget buildCustomButton(
    BuildContext context,
    String text,
    Widget destinationPage,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(24), // ripple matches shape
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 2, // Border width
          ),
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF2F2005), Color(0xFF92772C), Color(0xFF2F2005)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Nastaleeq',
              fontSize: 35,
              //height: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          'اردو',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Nastaleeq',
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: kToolbarHeight + 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              buildCustomButton(
                context,
                'عشق و معرفت ، پند و موعظت',
                const IshqList(),
              ),
              buildCustomButton(context, "نعتیں", Naat_list()),
              buildCustomButton(
                context,
                'مناقبِ نوریؒ',
                const DummyPage(title: 'Munaqib e Noori (RA)'),
              ),
              buildCustomButton(
                context,
                'نغمۂ سرمدی',
                SarmadiList(),
              ),
              buildCustomButton(
                context,
                'قندِ پارسی',
                const DummyPage(title: 'Qand-e-Parsi'),
              ),
              buildCustomButton(context, 'کلامِ عربی', ArabiList()),
              buildCustomButton(context, 'سلام', SalaamList()),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy destination page for navigation demo
class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 30))),
    );
  }
}
