
import 'package:Mehvesujood/api/firebase_api.dart';
import 'package:Mehvesujood/api/firebase_file.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackPlayerScreen extends StatefulWidget {
  final String title;
  final String firebaseImagePath;
  final String imageAsset;
  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackPlayerScreen({
    Key? key,
    required this.title,
    required this.firebaseImagePath,
    required this.imageAsset,
    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackPlayerScreen> createState() => _TrackPlayerScreenState();
}

class _TrackPlayerScreenState extends State<TrackPlayerScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late Future<List<FirebaseFile>> futureFiles;
  late String selectedArtist;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApi.listAll(widget.firebaseImagePath);
    if (widget.artistPaths.isNotEmpty) {
      selectedArtist = widget.artistPaths.keys.first;
      setAudio();
      audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      });

      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() => duration = newDuration);
      });

      audioPlayer.onPositionChanged.listen((newPosition) {
        setState(() => position = newPosition);
      });
    }
  }

  Future setAudio() async {
    try {
      final path = widget.artistPaths[selectedArtist]!;
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      await audioPlayer.setSourceUrl(url);
    } catch (e) {
      print('❌ Error loading audio: $e');
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E9DC),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(fontSize: 15, color: Colors.white),
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.brown.shade900,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Audio Player & Artist Selector
            widget.artistPaths.isNotEmpty
                ? Column(
                  children: [
                    /// 🎵 Artist Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          widget.artistPaths.keys.map((artist) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    selectedArtist == artist
                                        ? Colors.brown[400]
                                        : Colors.brown[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              onPressed: () async {
                                if (selectedArtist != artist) {
                                  setState(() {
                                    selectedArtist = artist;
                                    isPlaying = false;
                                    position = Duration.zero;
                                    duration = Duration.zero;
                                  });
                                  await audioPlayer.stop();
                                  await setAudio();
                                }
                              },
                              child: Text(
                                artist,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                    ),

                    /// 🎧 Player Card
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.brown,
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [Colors.brown, Colors.brown.shade900],
                              radius: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  widget.title,
                                  style: GoogleFonts.robotoCondensed(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.brown.shade100,
                                    ),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ), 
                              ),
                              Slider(
                                thumbColor: Colors.brown[300],
                                activeColor: Colors.brown[300],
                                inactiveColor: Colors.white,
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value:
                                    position.inSeconds
                                        .clamp(0, duration.inSeconds)
                                        .toDouble(),
                                onChanged: (value) async {
                                  await audioPlayer.seek(
                                    Duration(seconds: value.toInt()),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatTime(position),
                                      style: TextStyle(
                                        color: Colors.brown.shade100,
                                      ),
                                    ),
                                    Text(
                                      formatTime(duration),
                                      style: TextStyle(
                                        color: Colors.brown.shade100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.brown[300],
                                radius: 25,
                                child: IconButton(
                                  color: Colors.white,
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                  ),
                                  iconSize: 35,
                                  onPressed: () async {
                                    if (isPlaying) {
                                      await audioPlayer.pause();
                                    } else {
                                      await audioPlayer.resume();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.music_off,
                        size: 50,
                        color: Colors.brown,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '🎧 Audio will be available soon',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

            /// 📷 Image Title
            const SizedBox(height: 20),
            Image.asset(widget.imageAsset, height: 50),
            const SizedBox(height: 20),

            /// 🖼 Images from Firebase
            FutureBuilder<List<FirebaseFile>>(
              future: futureFiles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.brown),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return CachedNetworkImage(imageUrl: file.url);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
