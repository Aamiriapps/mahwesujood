import 'package:Mehvesujood/TrackScreenWebUrdu.dart';
import 'package:Mehvesujood/kalam/urdu/parsi/FarsiTrack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:Mehvesujood/main_drawer.dart';
 // import your trackData

class ParsiList extends StatelessWidget {
  const ParsiList({super.key});

  @override
  Widget build(BuildContext context) {
    final tileColors = ['#cbc0b8', '#ddd6ce'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'اردو   فہرست',
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
                      builder: (_) => TrackPlayerScreen(
                        title: track['title'],
                        webImageFolderPath: track['webImageFolderPath'],
                        webAudioBasePath: track['webAudioBasePath'],
                        imageAsset: track['imageAsset'],
                        artistPaths: Map<String, String>.from(track['artistPaths']),
                        appBarTitle: track['appBarTitle'],
                      ),
                    ),
                  );
                },
                title: Image.asset(track['imageListAsset']),
                trailing: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.brown, fontSize: 18),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
