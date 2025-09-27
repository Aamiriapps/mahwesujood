import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'package:Mehvesujood/main_drawer.dart';

class Trackclasssarmadiurdu extends StatefulWidget {
  final String title;
  final String nazam;
  final Map<String, String> artistPaths;
  final String appBarTitle;

  const Trackclasssarmadiurdu({
    super.key,
    required this.title,
    required this.nazam,
    required this.artistPaths,
    required this.appBarTitle,
  });

  @override
  State<Trackclasssarmadiurdu> createState() => _TrackclasssarmadiurduState();
}

class _TrackclasssarmadiurduState extends State<Trackclasssarmadiurdu> {
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

    audioPlayer.onPlayerComplete.listen((_) async {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
      await audioPlayer.seek(Duration.zero);
    });

    // loadPoetry();
  }

  /* Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString(widget.nazam);
      setState(() {
        stanzas = loadedText
            .trim()
            .split(RegExp(r'\n\s*\n'))
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      });
    } catch (e) {
      debugPrint('❌ Error loading kalam: $e');
    }
  } */

  Future<void> setAudio() async {
    try {
      final url = widget.artistPaths[selectedArtist]!;
      await audioPlayer.setSourceUrl(url);
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
    if (!isAudioAvailable) return;

    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      if (currentPosition >= totalDuration && totalDuration > Duration.zero) {
        await setAudio();
        await audioPlayer.resume();
      } else {
        await audioPlayer.resume();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (totalDuration.inMilliseconds > 0) {
      progress = (currentPosition.inMilliseconds / totalDuration.inMilliseconds)
          .clamp(0.0, 1.0);
    }

    final double canvasWidth = 260;
    final double strokeWidth = 12;
    final double buttonDiameter = 140;
    final double radiusPaint = canvasWidth / 2 - strokeWidth / 2;
    final double canvasHeight = radiusPaint + (buttonDiameter / 2);
    final double buttonTop = canvasHeight - buttonDiameter;

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
          style: GoogleFonts.gulzar(
            textStyle: const TextStyle(color: Colors.white, fontSize: 25),
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
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: canvasWidth,
                    height: canvasHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanUpdate: (details) {
                            if (!isAudioAvailable) return;
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
                          onTapDown: (details) {
                            if (!isAudioAvailable) return;
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
                                  color: isAudioAvailable
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
                    children: widget.artistPaths.keys.map((artist) {
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
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
                                  color: isSelected
                                      ? const Color(0xFF92772C)
                                      : Colors.white,
                                  fontWeight: isSelected
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
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَﷲُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Majeed',
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "میرے۱؎ دل کے قرار اور مری آرزو\n"
                          "رکھ لے دونوں جہاں میں مری آبرو\n"
                          "تیری خاطر میں پھرتا ہوں اب کو بکو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَﷲُ ",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "کے سِوا کچھ نہیں جستجو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَﷲُ   اَﷲُ   اَﷲُ   اَﷲُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎  حق تعالیٰ سے خطاب",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /* Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    TextSpan(
                      children: [
                        // Arabic word
                        TextSpan(
                          text: "اَلرَّحْمٰنُ\n",
                          style: GoogleFonts.gulzar(
                            fontSize: 36,
                            color: Colors.white,
                          ),
                        ),
                        // Urdu section
                        TextSpan(
                          text:
                              "میرے (۱) دل کے قرار اور مری آرزو\n"
                              "رکھ لے دونوں جہاں میں مری آبرو\n"
                              "تیری خاطر میں پھرتا ہوں اب کو بکو\n"
                              "اللہ ُ کے سِوا کچھ نہیں جستجو\n",

                          style: const TextStyle(
                            fontFamily: 'Alvi',
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        // Repeated Allah in Arabic style
                        TextSpan(
                          text: "اللہُ   اللہ  ُ  اللہ ُ   اللہُ ",
                          style: GoogleFonts.gulzar(
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    TextSpan(
                      children: [
                        // Arabic word
                        TextSpan(
                          text: "اَلرَّحْمٰنُ\n",
                          style: TextStyle(
                            fontFamily: 'Al_Majeed',
                            fontSize: 36,
                            color: Colors.white,
                          ),
                        ),
                        // Urdu section
                        TextSpan(
                          text:
                              "(۲) اب تلک ذات ہی کی سنی ہے خبر\n"
                              "بعد اسکے صفت کی ہے پھر رہ گذر\n"
                              "اک چھپے اک نظر آئے در ہر نظر\n"
                              "پوچھ رحمان کی گر ملے باخبر\n"
                              "مان    رحمان   کولَا   شَرِیکَ   لَہُ\n",

                          style: const TextStyle(
                            fontFamily: 'Alvi',
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        // Repeated Allah in Arabic style
                        TextSpan(
                          text: "اللہ ُ   اللہ  ُ  اللہ ُ   اللہُ ",
                          style: TextStyle(
                            fontFamily: 'Al_Majeed',
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}

class DecoratedTextBlock extends StatelessWidget {
  final List<TextSpan> spans;

  const DecoratedTextBlock({super.key, required this.spans});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
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
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
          child: Text.rich(
            TextSpan(children: spans),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
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

    final backgroundPaint = Paint()
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

    final progressPaint = Paint()
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
