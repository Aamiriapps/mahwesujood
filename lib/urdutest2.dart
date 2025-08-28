import 'dart:math' as math;
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_drawer.dart';

class TrackPlayerScreen2 extends StatefulWidget {
  final String title;
  final String imageAsset;
  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackPlayerScreen2({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackPlayerScreen2> createState() => _TrackPlayerScreenState();
}

class _TrackPlayerScreenState extends State<TrackPlayerScreen2> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late String selectedArtist;
  List<String> stanzas = [];
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.artistPaths.isNotEmpty) {
      selectedArtist = widget.artistPaths.keys.first;
      setAudio();
      audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      });
    }

    // Listen to duration changes
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() => totalDuration = duration);
    });

    // Listen to position changes
    audioPlayer.onPositionChanged.listen((position) {
      setState(() => currentPosition = position);
    });

    // Listen to completion
    audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
    });

    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString('assets/71.txt');
      setState(() {
        stanzas =
            loadedText
                .trim()
                .split(RegExp(r'\n\s*\n'))
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
      });
      print('✅ Loaded ${stanzas.length} stanzas');
    } catch (e) {
      debugPrint('❌ Error loading kalam: $e');
    }
  }

  Future<void> setAudio() async {
    try {
      // final url = widget.artistPaths[selectedArtist]!;
      await audioPlayer.setSourceUrl(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      );
    } catch (e) {
      debugPrint('❌ Error loading audio: $e');
    }
  }

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        totalDuration.inMilliseconds > 0
            ? currentPosition.inMilliseconds / totalDuration.inMilliseconds
            : 0;
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
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'ISHQ-o-MARIFAT test2',
          style: GoogleFonts.robotoCondensed(
            textStyle: TextStyle(color: Colors.white),
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
            /// Audio Player UI
            Stack(
              alignment: Alignment.center,
              children: [
                // Circular progress
                CustomPaint(
                  size: const Size(260, 260),
                  painter: CircleProgressPainter(progress),
                ),

                // Main circular button
                // Inside your Stack (replace old GestureDetector section)
                GestureDetector(
                  onTap: togglePlayPause,
                  child: Container(
                    padding: const EdgeInsets.all(5), // space for gradient ring
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2F2005),
                          Color(0xFF92772C),
                          Color(0xFF2F2005), // darker
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
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Color(0xFF342611),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 120,
                        color: Color(0xFFab9a87),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //  const SizedBox(height: 16),
            const SizedBox(height: 5),
            /* Text(
              'حمدِ بے حد',
              style: GoogleFonts.gulzar(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 3.0,
              ),
              textAlign: TextAlign.center,
            ), */
            const SizedBox(height: 10),

            /// Poetry tiles
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
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2F2005),
                        Color(0xFF92772C),
                        Color(0xFF2F2005),
                      ],
                      begin: Alignment.centerLeft, // 90-degree horizontal
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
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.gulzar(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 3.0,
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

// Custom painter for circular progress
class CircleProgressPainter extends CustomPainter {
  final double progress;

  CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final radius = (size.width / 2) - strokeWidth / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Background circle
    final backgroundPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.2)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [Color(0xFFab9a87), Color(0xFF2F2005), Color(0xFF92772C)],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
