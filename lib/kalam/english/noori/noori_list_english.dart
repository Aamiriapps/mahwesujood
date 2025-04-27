/*  import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/noori/nooriTrackEnglish.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class NooriListEnglish extends StatelessWidget {
  const NooriListEnglish({super.key});

 
   @override
  Widget build(BuildContext context) {
    final tileColors = ['#cbc0b8', '#ddd6ce'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
         'List',
          style: GoogleFonts.robotoCondensed( color: Colors.white)// TextStyle(fontFamily: 'Mehr', fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MainDrawer(),
      body: Container(
        color: Colors.brown.shade900,
        child: ListView.builder(
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
                title: Image.asset(track['imageListAsset'],height: 18,),
                leading: Text('${index + 1}', style: const TextStyle(color: Colors.brown,fontSize: 18)),
              ),
            );
          },
        ),
      ),
    );
  }
}
 */

import 'package:Mehvesujood/TrackClassEnglish.dart';
import 'package:Mehvesujood/kalam/english/noori/nooriTrackEnglish.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class NooriListEnglish extends StatelessWidget {
  const NooriListEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    final tileColors = ['#cbc0b8', '#ddd6ce'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'List',
          style: GoogleFonts.robotoCondensed(color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MainDrawer(),
      body: Container(
        color: Colors.brown.shade900,
        child: ListView.builder(
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
                      builder:
                          (_) => TrackPlayerScreen(
                            title: track['title'],
                            firebaseImagePath: track['firebaseImagePath'],
                            imageAsset: track['imageAsset'],
                            artistPaths: Map<String, String>.from(
                              track['artistPaths'],
                            ),
                            appBarTitle: track['appBarTitle'],
                          ),
                    ),
                  );
                },
                title: Text(
                  track['imageListAsset'], // now showing text instead of image
                  style: GoogleFonts.quicksand(
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                leading: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
