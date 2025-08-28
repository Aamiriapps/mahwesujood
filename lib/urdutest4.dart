/* import 'dart:math' as math;
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_drawer.dart';

class TrackPlayerScreen4 extends StatefulWidget {
  final String title;
  final String imageAsset;
  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackPlayerScreen4({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackPlayerScreen4> createState() => _TrackPlayerScreenState();
}

class _TrackPlayerScreenState extends State<TrackPlayerScreen4> {
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
      final String loadedText = await rootBundle.loadString('assets/75.txt');
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
    // Remove the manual setState — rely on onPlayerStateChanged listener
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
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox;
                    final local = box.globalToLocal(details.globalPosition);
                    final dx = local.dx.clamp(0.0, box.size.width);
                    final progress = dx / box.size.width; // 0 to 1 left→right
                    final newPosition = totalDuration * progress;
                    audioPlayer.seek(newPosition);
                  },
                  child: CustomPaint(
                    size: const Size(260, 130),
                    painter: SemiCircleProgressPainter(progress),
                  ),
                ),

                /*  GestureDetector(
                  onPanUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox;
                    final localPos = box.globalToLocal(details.globalPosition);
                    final center = Offset(
                      box.size.width / 2,
                      box.size.height / 2,
                    );
                    final dx = localPos.dx - center.dx;
                    final dy = localPos.dy - center.dy;
                    final angle = math.atan2(dy, dx);

                    // Only respond to upper semi-circle (angle between -π and 0)
                    if (angle >= -math.pi && angle <= 0) {
                      final progress = (angle + math.pi) / math.pi; // 0 to 1
                      final newPosition = totalDuration * progress;
                      audioPlayer.seek(newPosition);
                    }
                  },
                  child: CustomPaint(
                    size: const Size(260, 130), // half height for semi-circle
                    painter: SemiCircleProgressPainter(progress),
                  ),
                ), */

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
                      style: TextStyle(
                        fontFamily:
                            'Nastaleeq', // Use the family name declared in pubspec.yaml
                        fontSize: 38,
                        color: Colors.white,
                      ),

                      /* GoogleFonts.gulzar(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 3.0,
                      ), */
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
  SemiCircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final radius = (size.width / 2) - strokeWidth / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Background semi-circle
    final backgroundPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.2)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, // Start from left
      math.pi, // Half circle
      false,
      backgroundPaint,
    );

    // Progress arc
    final progressPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [Color(0xFFab9a87), Color(0xFF2F2005), Color(0xFF92772C)],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final sweepAngle = math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(SemiCircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
 */

/*
class TrackPlayerScreen4 extends StatefulWidget {
  final String title;
  final String nazam;

  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackPlayerScreen4({
    Key? key,
    required this.title,
    required this.nazam,
    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackPlayerScreen4> createState() => _TrackPlayerScreenState();
}

class _TrackPlayerScreenState extends State<TrackPlayerScreen4> {
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

  /*  Future<void> setAudio() async {
    try {
      // final url = widget.artistPaths[selectedArtist]!;
      //await audioPlayer.setSourceUrl(url);

      await audioPlayer.setSourceUrl(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      );
    } catch (e) {
      debugPrint('❌ Error loading audio: $e');
    }
  } */

 Future<void> setAudio() async {
    try {
      final url = widget.artistPaths[selectedArtist]!;
      await audioPlayer.setSourceUrl(url);

      //await audioPlayer.setSourceUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',);
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

  /* void togglePlayPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
  } */

  void togglePlayPause() async {
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

                        // Positioned central circular play/pause button
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
                                  isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  size: (buttonDiameter * 0.45).clamp(
                                    36.0,
                                    120.0,
                                  ),
                                  color: const Color(0xFFab9a87),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Selected Artist Name
                  Text(
                    selectedArtist,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Time labels
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

            // Artist selection buttons
            /*  Row(
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
                            currentPosition = Duration.zero;
                            totalDuration = Duration.zero;
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
            ), */
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3), // Space for border
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Color(0xFF92772C)
                                        : Color(0xFF2F2005),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/sarkar.png', // Asset image for artist
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            artist,
                            style: TextStyle(
                              color:
                                  isSelected ? Color(0xFF92772C) : Colors.white,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ), */
            SizedBox(
              height: 120, // Enough to fit the circles + text
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      widget.artistPaths.keys.map((artist) {
                        bool isSelected = selectedArtist == artist;

                        return TweenAnimationBuilder<Offset>(
                          tween: Tween<Offset>(
                            begin: const Offset(1, 0), // Start off to the right
                            end: Offset.zero, // Slide to normal position
                          ),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          builder: (context, offset, child) {
                            return Transform.translate(
                              offset: Offset(
                                offset.dx * 200,
                                0,
                              ), // Adjust speed
                              child: GestureDetector(
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
                                        padding: const EdgeInsets.all(
                                          3,
                                        ), // Space for border
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
                                          child: Image.asset(
                                           'assets/$artist.png', // Asset image for artist
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
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
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nastaleeq',
                fontSize: 45,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Poetry display
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
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      stanza,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: 'Nastaleeq',
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
  final double progress; // 0..1
  final double strokeWidth;
  final double buttonDiameter;

  SemiCircleProgressPainter(
    this.progress, {
    this.strokeWidth = 12.0,
    this.buttonDiameter = 140.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // center is placed so the circle center's y == (size.height - buttonDiameter/2)
    // This makes the top of the arc at y=0 and the button centered at the circle center.
    final center = Offset(size.width / 2, size.height - (buttonDiameter / 2));
    final radius = (size.width / 2) - (strokeWidth / 2);

    final backgroundPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.18)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    // draw full background semicircle (top half)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, // start at left
      math.pi, // sweep top half
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
*/
import 'dart:math' as math;
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_drawer.dart';

class TrackPlayerScreen4 extends StatefulWidget {
  final String title;
  final String nazam;
  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackPlayerScreen4({
    Key? key,
    required this.title,
    required this.nazam,
    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackPlayerScreen4> createState() => _TrackPlayerScreenState();
}

class _TrackPlayerScreenState extends State<TrackPlayerScreen4> {
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
              style: const TextStyle(
                fontFamily: 'Nastaleeq',
                fontSize: 45,
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
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: 'Nastaleeq',
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
