/* import 'dart:ui';

import 'package:Mehvesujood/kalam/urdu/salaam/salaamTrack.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/urdutest4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class salaam_list extends StatelessWidget {
  const salaam_list({super.key});
  // Load song titles from text file
  Future<List<String>> loadSongList() async {
    final content = await rootBundle.loadString(
      'assets/salam_list/urdu/urduList.txt', // adjust path as needed
    );
    return content
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final tileColors = ['#cbc0b8', '#ddd6ce'];

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
          'اردو فہرست',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Nastaleeq',
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      /*     appBar: AppBar(
        centerTitle: true,
        title: Text(
          'اردو   فہرست',
          style: GoogleFonts.notoNastaliqUrdu(color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MainDrawer(), */
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<String>>(
          future: loadSongList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final songList = snapshot.data!;
            return ListView.builder(
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final track =
                    index < trackData.length ? trackData[index] : null;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
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
                  child: ListTile(
                    onTap:
                        track != null
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TrackPlayerScreen4(
                                        title: track['title'],
                                        nazam: track['nazam'],
                                        imageAsset: track['imageAsset'],
                                        artistPaths: Map<String, String>.from(
                                          track['artistPaths'],
                                        ),
                                        appBarTitle: track['appBarTitle'],
                                      ),
                                ),
                              );
                            }
                            : null,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF2F2005),
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Rounded square
                        border: Border.all(
                          color: Color(0xFF2F2005),
                          width: 2,
                        ), // optional border
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      songList[index],
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                        color: Colors.white,

                        //  fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // Only one line
                      overflow:
                          TextOverflow.ellipsis, // Show "..." if text overflows
                      softWrap: false,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
 */

import 'dart:ui';
import 'package:Mehvesujood/TrackClassArabic.dart';
import 'package:Mehvesujood/kalam/urdu/salaam/salaamTrack.dart';
import 'package:Mehvesujood/main_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SalaamList extends StatelessWidget {
  const SalaamList({super.key});

  // Load song titles from text file
  Future<List<String>> loadSongList() async {
    final content = await rootBundle.loadString(
      'assets/salaam_list/urdu/urduList.txt',
    );
    return content
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);
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
          'اردو فہرست',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Nastaleeq',
            fontSize: 30,
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
        child: FutureBuilder<List<String>>(
          future: loadSongList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No songs found",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            final songList = snapshot.data!;
            return ListView.builder(
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final track =
                    index < trackData.length ? trackData[index] : null;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
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
                  child: ListTile(
                    onTap:
                        track != null
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TrackPlayerScreenArabic(
                                        title: track['title'],
                                        nazam: track['nazam'],

                                        artistPaths: Map<String, String>.from(
                                          track['artistPaths'],
                                        ),
                                        appBarTitle: track['appBarTitle'],
                                      ),
                                ),
                              );
                            }
                            : null,
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F2005),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF2F2005),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      songList[index],
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.gulzar(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
