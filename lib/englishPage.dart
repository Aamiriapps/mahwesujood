/* import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/ishq/ishqListEnglish.dart';
import 'package:Mehvesujood/kalam/english/naat/naat_list_english.dart';
import 'package:Mehvesujood/kalam/english/noori/noori_list_english.dart';
import 'package:Mehvesujood/kalam/english/parsi/parsi_list_english.dart';

import 'package:Mehvesujood/main_drawer.dart';

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
                                  builder: (context) => Naat_list_english(),
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
                              'assets/eng_button/5.png',
                              height: 140,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParsiListEnglish(),
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
                              height: 140,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NooriListEnglish(),
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
                              height: 140,
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
                                            'assets/arabi_title/english/1.png',
                                        artistPaths: {
                                          'Danish':
                                              'kalam/Audios/Danish/Sarmadi/1.mp3',
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
                              height: 140,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => TrackPlayerScreen(
                                        title: 'AL MANAJATH',
                                        firebaseImagePath: '/',
                                        imageAsset:
                                            'assets/arabi_title/english/1.png',
                                        artistPaths: {},
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
                                height: 140,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TrackPlayerScreen(
                                          title: 'SALAMUN MALAHU ADAD',
                                          firebaseImagePath:
                                              'kalam/English/Salaam',
                                          imageAsset:
                                              'assets/arabi_title/english/2.png',
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
/* import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/ishq/ishqListEnglish.dart';
import 'package:Mehvesujood/kalam/english/naat/naat_list_english.dart';
import 'package:Mehvesujood/kalam/english/noori/noori_list_english.dart';
import 'package:Mehvesujood/kalam/english/parsi/parsi_list_english.dart';

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
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120.0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white), // keeps menu icon visible
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.brown.shade900.withOpacity(0.5),
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'English',
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildButtonRow(
                    context,
                    'assets/eng_button/2.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Naat_list_english()),
                    ),
                    'assets/eng_button/1.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => IshqList()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildButtonRow(
                    context,
                    'assets/eng_button/5.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ParsiListEnglish()),
                    ),
                    'assets/eng_button/3.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NooriListEnglish()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildButtonRow(
                    context,
                    'assets/eng_button/4.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrackPlayerScreen(
                          title: 'NAGHMA-E-SARMADI',
                          firebaseImagePath: 'kalam/English/Naghma_e_sarmadi',
                          imageAsset: 'assets/arabi_title/english/1.png',
                          artistPaths: {
                            'Danish': 'kalam/Audios/Danish/Sarmadi/1.mp3',
                          },
                          appBarTitle: 'Naghme-e-Sarmadi',
                        ),
                      ),
                    ),
                    'assets/eng_button/6.png',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrackPlayerScreen(
                          title: 'AL MANAJATH',
                          firebaseImagePath: 'kalam/English/Al_Manajath/',
                          imageAsset: 'assets/arabi_title/english/5.png',
                          artistPaths: {},
                          appBarTitle: 'Arabi Kalaam',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 2,
                        child: _buildSingleButton(
                          context,
                          'assets/eng_button/7.png',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrackPlayerScreen(
                                title: 'SALAMUN MALAHU ADAD',
                                firebaseImagePath: 'kalam/English/Salaam',
                                imageAsset: 'assets/arabi_title/english/2.png',
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
        ],
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
        const SizedBox(width: 16),
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
        aspectRatio: 1, // keeps it square
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
 */

import 'dart:ui';
import 'package:Mehvesujood/kalam/urdu/naat/naat_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/ishq/ishqListEnglish.dart';
import 'package:Mehvesujood/kalam/english/naat/naat_list_english.dart';
import 'package:Mehvesujood/kalam/english/noori/noori_list_english.dart';
import 'package:Mehvesujood/kalam/english/parsi/parsi_list_english.dart';
/* 
class Englishpage extends StatefulWidget {
  const Englishpage({super.key});

  @override
  State<Englishpage> createState() => _EnglishpageState();
}

class _EnglishpageState extends State<Englishpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          'English',
          style: GoogleFonts.robotoCondensed(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16, // Push content below AppBar
            left: 25,
            right: 25,
            bottom: 16,
          ),
          child: Column(
            children: [
              SizedBox(height: 75),
              _buildButtonRow(
                context,
                'assets/eng_button/2.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Naat_list_english()),
                ),
                'assets/eng_button/1.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => IshqList()),
                ),
              ),
            //  const SizedBox(height: 16),
              _buildButtonRow(
                context,
                'assets/eng_button/5.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ParsiListEnglish()),
                ),
                'assets/eng_button/3.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NooriListEnglish()),
                ),
              ),
              //const SizedBox(height: 16),
              _buildButtonRow(
                context,
                'assets/eng_button/4.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'NAGHMA-E-SARMADI',
                          firebaseImagePath: 'kalam/English/Naghma_e_sarmadi',
                          imageAsset: 'assets/arabi_title/english/1.png',
                          artistPaths: {
                            'Danish': 'kalam/Audios/Danish/Sarmadi/1.mp3',
                          },
                          appBarTitle: 'Naghme-e-Sarmadi',
                        ),
                  ),
                ),
                'assets/eng_button/6.png',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => TrackPlayerScreen(
                          title: 'AL MANAJATH',
                          firebaseImagePath: 'kalam/English/Al_Manajath/',
                          imageAsset: 'assets/arabi_title/english/5.png',
                          artistPaths: {},
                          appBarTitle: 'Arabi Kalaam',
                        ),
                  ),
                ),
              ),
            //  const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: _buildSingleButton(
                      context,
                      'assets/eng_button/7.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TrackPlayerScreen(
                                title: 'SALAMUN MALAHU ADAD',
                                firebaseImagePath: 'kalam/English/Salaam',
                                imageAsset: 'assets/arabi_title/english/2.png',
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
      //  const SizedBox(width: 16),
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
          scale: 0.80, // Shrinks the image to 75% (i.e., 25% smaller)
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
 */

class Englishpage extends StatelessWidget {
  const Englishpage({Key? key}) : super(key: key);

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

            style: GoogleFonts.cormorantGaramond(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                height: 2,
              ),
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
        title: Text(
          'English',
          style: GoogleFonts.robotoCondensed(
            height: 2,
            textStyle: const TextStyle(color: Colors.white),
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
                'Ishq-o-Marifat Pandh-o-Muzath',
                const IshqList(),
              ),
              buildCustomButton(context, "Naath'en", Naat_list_english()),
              buildCustomButton(
                context,
                'Munaqib-e-Noori(RA)',
                const DummyPage(title: 'Munaqib e Noori (RA)'),
              ),
              buildCustomButton(
                context,
                'Naghma-e-Sarmadi',
                const DummyPage(title: 'Naghma-e-Sarmadi'),
              ),
              buildCustomButton(
                context,
                'Qand-e-Parsi',
                const DummyPage(title: 'Qand-e-Parsi'),
              ),
              buildCustomButton(
                context,
                'Kalaam-e-Arabi',
                const DummyPage(title: 'Kalaam-e-Arabi'),
              ),
              buildCustomButton(
                context,
                'Salaam',
                const DummyPage(title: 'Salaam'),
              ),
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
