/* import 'package:Mehvesujood/TrackClassUrdu.dart';

import 'package:Mehvesujood/kalam/urdu/naat/naatTrack.dart';

import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hexcolor/hexcolor.dart';

class Naat_list extends StatelessWidget {
  const Naat_list({Key? key}) : super(key: key);

  // inside Naat_list widget
  Future<List<String>> loadSongList() async {
    final content = await rootBundle.loadString(
      'assets/naat_list/english/englist.txt',
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'اردو   فہرست',
          style: GoogleFonts.notoNastaliqUrdu(
            color: Colors.white,
          ), // TextStyle(fontFamily: 'Mehr', fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MainDrawer(),
      body: Container(
  color: Colors.brown.shade900,
  child: FutureBuilder<List<String>>(
    future: loadSongList(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }

      final songList = snapshot.data!;
      return ListView.builder(
        itemCount: trackData.length,
        itemBuilder: (context, index) {
          final track = trackData[index];
          final color = HexColor(tileColors[index % tileColors.length]);

          return Card(
            color: color,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackPlayerScreen(
                      title: track['title'],
                      firebaseImagePath: track['firebaseImagePath'],
                      imageAsset: track['imageAsset'],
                      artistPaths: Map<String, String>.from(track['artistPaths']),
                      appBarTitle: track['appBarTitle'],
                    ),
                  ),
                );
              },
              // Replace image with text from txt file
              title: Text(
                songList.length > index ? songList[index] : track['title'],
                style: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 20,
                  color: Colors.brown.shade900,
                ),
              ),
              trailing: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.brown, fontSize: 18),
              ),
            ),
          );
        },
      );
    },
  ),
)
) */

import 'dart:ui';

import 'package:Mehvesujood/kalam/urdu/naat/naatTrack.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:Mehvesujood/urdutest4.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;

// make sure this is imported for trackData

class Naat_list extends StatelessWidget {
  const Naat_list({Key? key}) : super(key: key);

  // Load song titles from text file
  Future<List<String>> loadSongList() async {
    final content = await rootBundle.loadString(
      'assets/naat_list/urdu/naat_list.txt', // adjust path as needed
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
                      style: const TextStyle(
                        fontFamily: 'Nastaleeq',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      maxLines: 1, // Only one line
                      textDirection: TextDirection.rtl,
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
