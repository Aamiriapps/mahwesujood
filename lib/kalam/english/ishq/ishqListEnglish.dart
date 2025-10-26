import 'dart:ui';

import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/ishq/ishqTrackEnglish.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:Mehvesujood/main_drawer.dart';
// ← Import your data file

class IshqList extends StatelessWidget {
  const IshqList({Key? key}) : super(key: key);

  // Load song titles from text file
  Future<List<String>> loadSongList() async {
    final content = await rootBundle.loadString(
      'assets/kalam_list/english/engList.txt', // adjust path as needed
    );
    return content
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // final tileColors = ['#cbc0b8', '#ddd6ce'];

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
          style: GoogleFonts.cormorantGaramond(
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
                final track = index < trackData.length
                    ? trackData[index]
                    : null;

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
                    onTap: track != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TrackClassEnglishNew(
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

                      style: TextStyle(
                        fontFamily: 'Trajan',
                        fontSize: 18,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,

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
