import 'dart:math' as math;
import 'dart:ui';

import 'package:Mehvesujood/api/firebase_api.dart';
import 'package:Mehvesujood/api/firebase_file.dart';
import 'package:Mehvesujood/main_drawer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '🎧 Audio will be available soon',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

            /// 📷 Image Title
            const SizedBox(height: 20),
            Image.asset(widget.imageAsset, height: 20),
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

class TrackClassEnglishNew extends StatefulWidget {
  final String title;
  final String nazam;

  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackClassEnglishNew({
    Key? key,
    required this.title,
    required this.nazam,

    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackClassEnglishNew> createState() => _TrackPlayerScreenNewState();
}

class _TrackPlayerScreenNewState extends State<TrackClassEnglishNew> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late String selectedArtist;
  List<String> stanzas = [];
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  bool get isAudioAvailable => widget.artistPaths.isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (isAudioAvailable) {
      selectedArtist = widget.artistPaths.keys.first;
      setAudio();
      audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      });
    }

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() => totalDuration = duration);
    });

    audioPlayer.onPositionChanged.listen((position) {
      setState(() => currentPosition = position);
    });

    /* audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
    }); */

    audioPlayer.onPlayerComplete.listen((_) async {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
      await audioPlayer.seek(Duration.zero);
    });

    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString(widget.nazam);
      setState(() {
        stanzas =
            loadedText
                .trim()
                .split(RegExp(r'\n\s*\n'))
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
      });
    } catch (e) {
      debugPrint('❌ Error loading kalam: $e');
    }
  }

  Future<void> setAudio() async {
    try {
      final url = widget.artistPaths[selectedArtist]!;
      await audioPlayer.setSourceUrl(url);

      //await audioPlayer.setSourceUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',);
    } catch (e) {
      debugPrint('❌ Error loading audio: $e');
    }
  }

  /*  Future<void> setAudio() async {
    try {
      // Example: pick audio file based on selectedArtist
      final assetPath = widget.artistPaths[selectedArtist]!;
      await audioPlayer.setSource(AssetSource(assetPath));
    } catch (e) {
      debugPrint('❌ Error loading audio: $e');
    }
  } */

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  /* void togglePlayPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
  } */

  void togglePlayPause() async {
    if (!isAudioAvailable) return;
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      if (currentPosition >= totalDuration && totalDuration > Duration.zero) {
        // Re-load the audio and play from start
        await setAudio();
        await audioPlayer.resume(); // or play() if you prefer
      } else {
        await audioPlayer.resume();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // progress clamped 0..1
    double progress = 0;
    if (totalDuration.inMilliseconds > 0) {
      progress = (currentPosition.inMilliseconds / totalDuration.inMilliseconds)
          .clamp(0.0, 1.0);
    }

    // Layout constants for semicircle + central button
    // You can tweak these to change sizes.
    final double canvasWidth = 260; // overall width of the semicircle canvas
    final double strokeWidth = 12; // arc thickness
    final double buttonDiameter = 140; // central circular button size
    // radius used for drawing the arc (outer radius)
    final double radiusPaint = canvasWidth / 2 - strokeWidth / 2;
    // height of the CustomPaint canvas:
    // We want the top of the arc to be at y=0 and the center of the circle at y = radiusPaint.
    // We also want space below the center to place the circular button; by choosing
    // canvasHeight = radiusPaint + (buttonDiameter / 2) the button will be centered on the circle center.
    final double canvasHeight = radiusPaint + (buttonDiameter / 2);
    final double buttonTop =
        canvasHeight -
        buttonDiameter; // where to place the button's top inside the stack

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
          widget.appBarTitle,
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(top: kToolbarHeight, bottom: 24),
        child: ListView(
          children: [
            // Integrated Semi-circle + Play Button + Artist Name + Time
            Center(
              child: Column(
                children: [
                  // Stack that contains the semicircle CustomPaint and the positioned circular button
                  SizedBox(
                    width: canvasWidth,
                    height: canvasHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // GestureDetector limited to the CustomPaint area for drag seeking
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanUpdate: (details) {
                            // use localPosition within the gesture region
                            final local = details.localPosition;
                            // clamp dx within [0, canvasWidth]
                            double dx = local.dx.clamp(0.0, canvasWidth);
                            if (totalDuration.inMilliseconds > 0) {
                              final double prog = (dx / canvasWidth).clamp(
                                0.0,
                                1.0,
                              );
                              final newPosition = Duration(
                                milliseconds:
                                    (totalDuration.inMilliseconds * prog)
                                        .round(),
                              );
                              audioPlayer.seek(newPosition);
                            }
                          },
                          onTapDown: (details) {
                            final local = details.localPosition;
                            double dx = local.dx.clamp(0.0, canvasWidth);
                            if (totalDuration.inMilliseconds > 0) {
                              final double prog = (dx / canvasWidth).clamp(
                                0.0,
                                1.0,
                              );
                              final newPosition = Duration(
                                milliseconds:
                                    (totalDuration.inMilliseconds * prog)
                                        .round(),
                              );
                              audioPlayer.seek(newPosition);
                            }
                          },
                          child: CustomPaint(
                            size: Size(canvasWidth, canvasHeight),
                            painter: SemiCircleProgressPainter(
                              progress.clamp(0.0, 1.0),
                              strokeWidth: strokeWidth,
                              buttonDiameter: buttonDiameter,
                            ),
                          ),
                        ),

                        Positioned(
                          left: (canvasWidth - buttonDiameter) / 2,
                          top: buttonTop,
                          child: GestureDetector(
                            onTap: togglePlayPause,
                            child: Container(
                              width: buttonDiameter,
                              height: buttonDiameter,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2F2005),
                                    Color(0xFF92772C),
                                    Color(0xFF2F2005),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  isAudioAvailable
                                      ? (isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded)
                                      : Icons.music_off_rounded,
                                  size: (buttonDiameter * 0.45).clamp(
                                    36.0,
                                    120.0,
                                  ),
                                  color:
                                      isAudioAvailable
                                          ? const Color(0xFFab9a87)
                                          : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Artist Name or Audio coming soon
                  Text(
                    isAudioAvailable ? selectedArtist : "Audio coming soon",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Time labels
                  if (isAudioAvailable)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(currentPosition),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            formatTime(totalDuration),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Artist selector (only if audio exists)
            if (isAudioAvailable)
              SizedBox(
                height: 120,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        widget.artistPaths.keys.map((artist) {
                          bool isSelected = selectedArtist == artist;
                          return GestureDetector(
                            onTap: () async {
                              if (selectedArtist != artist) {
                                setState(() {
                                  selectedArtist = artist;
                                  isPlaying = false;
                                  currentPosition = Duration.zero;
                                  totalDuration = Duration.zero;
                                });
                                await audioPlayer.stop();
                                await setAudio();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? const Color(0xFF92772C)
                                                : const Color(0xFF2F2005),
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.white,
                                        child: Image.asset(
                                          'assets/$artist.png',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    artist,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? const Color(0xFF92772C)
                                              : Colors.white,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),

            const SizedBox(height: 10),

            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                fontSize: 35,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            if (stanzas.isNotEmpty)
              ...stanzas.map(
                (stanza) => Container(
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
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      stanza,
                      textAlign: TextAlign.center,

                      style: GoogleFonts.cormorantGaramond(
                        // fontFamily: 'Nastaleeq',
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    "📜 Kalam not found.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SemiCircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final double buttonDiameter;

  SemiCircleProgressPainter(
    this.progress, {
    this.strokeWidth = 12.0,
    this.buttonDiameter = 140.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - (buttonDiameter / 2));
    final radius = (size.width / 2) - (strokeWidth / 2);

    final backgroundPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.18)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    final progressPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [Color(0xFFab9a87), Color(0xFF92772C), Color(0xFF2F2005)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final sweepAngle = math.pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SemiCircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.buttonDiameter != buttonDiameter;
  }
}
