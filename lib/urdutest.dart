/* //first design blue colour without tile//
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_drawer.dart'; // Adjust path as needed

class UrduPoetryScreen extends StatefulWidget {
  const UrduPoetryScreen({Key? key}) : super(key: key);

  @override
  State<UrduPoetryScreen> createState() => _UrduPoetryScreenState();
}

class _UrduPoetryScreenState extends State<UrduPoetryScreen> {
  String poetryText = '';

  @override
  void initState() {
    super.initState();
    loadPoetry();
  }

  Future<void> loadPoetry() async {
    final String loadedText = await rootBundle.loadString(
      'assets/testkalam.txt',
    );
    setState(() {
      poetryText = loadedText; // Keep line breaks for proper multiline display
    });
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
        title: Text(
          'Urdu Poetry',
          style: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.only(
          top: kToolbarHeight + 40,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Text(
              poetryText,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'NotoNastaliqUrdu',
                color: Colors.white,
                height: 2.0, // line spacing for readability
              ),
            ),
          ),
        ),
      ),
    );
  }
} */

/* import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_drawer.dart';

class UrduPoetryScreen extends StatefulWidget {
  const UrduPoetryScreen({Key? key}) : super(key: key);

  @override
  State<UrduPoetryScreen> createState() => _UrduPoetryScreenState();
}

class _UrduPoetryScreenState extends State<UrduPoetryScreen> {
  List<String> stanzas = [];

  @override
  void initState() {
    super.initState();
    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString(
        'assets/testkalam.txt',
      );

      setState(() {
        // Splitting stanzas using two or more line breaks
        stanzas =
            loadedText
                .trim()
                .split(RegExp(r'\n\s*\n'))
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
      });
    } catch (e) {
      debugPrint('❌ Error loading poetry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Urdu Poetry',
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown.shade900,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 16),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.black, Colors.brown.shade900],
            radius: 0.8,
          ),
        ),
        child:
            stanzas.isEmpty
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: stanzas.length,
                  itemBuilder: (context, index) {
                    final stanza = stanzas[index];
                    final bgImage =
                        index % 2 == 0
                            ? 'assets/urdudarktile.png'
                            : 'assets/urdulighttile.png';

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(bgImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        stanza,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.notoNastaliqUrdu(
                          color: Colors.brown.shade900,
                          fontSize: 18,
                          height:
                              2.2, // Increase for more spacing between lines
                          wordSpacing:
                              5, // Adjust for better horizontal distribution
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    );
                  },
                ),
      ),
    );
  }
} */

/* //Main test work
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_drawer.dart';

class UrduPoetryScreen extends StatefulWidget {
  const UrduPoetryScreen({Key? key}) : super(key: key);

  @override
  State<UrduPoetryScreen> createState() => _UrduPoetryScreenState();
}

class _UrduPoetryScreenState extends State<UrduPoetryScreen> {
  List<String> stanzas = [];

  @override
  void initState() {
    super.initState();
    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString(
        'assets/testkalam.txt',
      );

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
      debugPrint('❌ Error loading poetry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Urdu Poetry',
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown.shade900,
      ),
      body: Container(
        //padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 16),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.black, Colors.brown.shade900],
            radius: 0.8,
          ),
        ),
        child:
            stanzas.isEmpty
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : ListView.builder(
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: stanzas.length,
                  itemBuilder: (context, index) {
                    final stanza = stanzas[index];
                    final bgImage =
                        index % 2 == 0
                            ? 'assets/urdudarktile.png'
                            : 'assets/urdulighttile.png';

                    return Container(
                      ///margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(bgImage),
                          fit: BoxFit.cover,
                        ),
                        // borderRadius: BorderRadius.circular(12),
                      ),
                      // padding: const EdgeInsets.all(4),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth = constraints.maxWidth;
                          double fontSize = (screenWidth * 0.05).clamp(
                            18.0,
                            22.0,
                          ); // Adjust range as needed

                          return Text(
                            stanza,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoNastaliqUrdu(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade900,
                              height: 3.5,
                              //wordSpacing: 2,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
} */

/*
//Font from Aadil shahsaab
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_drawer.dart';

class UrduPoetryScreen extends StatefulWidget {
  const UrduPoetryScreen({Key? key}) : super(key: key);

  @override
  State<UrduPoetryScreen> createState() => _UrduPoetryScreenState();
}

class _UrduPoetryScreenState extends State<UrduPoetryScreen> {
  List<String> stanzas = [];

  @override
  void initState() {
    super.initState();
    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString(
        'assets/testkalam.txt',
      );

      setState(() {
        stanzas =
            loadedText
                .trim()
                .split(RegExp(r'\n\s*\n')) // Split stanzas by empty lines
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
      });
    } catch (e) {
      debugPrint('❌ Error loading poetry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Adjust font size based on screen width
    final double fontSize = (screenWidth * 0.045).clamp(14.0, 22.0);

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Urdu Poetry',
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown.shade900,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 16),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.black, Colors.brown.shade900],
            radius: 0.8,
          ),
        ),
        child:
            stanzas.isEmpty
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: stanzas.length,
                  itemBuilder: (context, index) {
                    final stanza = stanzas[index];
                    final bgImage =
                        index % 2 == 0
                            ? 'assets/urdudarktile.png'
                            : 'assets/urdulighttile.png';

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(bgImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        stanza,
                        style: TextStyle(
                          fontFamily: 'FajerNoori',
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                          height: 2.2,

                          wordSpacing: 10,
                          shadows: [
                            Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
*/
/* 
//test with background
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_drawer.dart';

class UrduPoetryScreen extends StatefulWidget {
  const UrduPoetryScreen({Key? key}) : super(key: key);

  @override
  State<UrduPoetryScreen> createState() => _UrduPoetryScreenState();
}

class _UrduPoetryScreenState extends State<UrduPoetryScreen> {
  List<String> stanzas = [];

  @override
  void initState() {
    super.initState();
    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString(
        'assets/testkalam.txt',
      );

      setState(() {
        stanzas =
            loadedText
                .trim()
                .split(RegExp(r'\n\s*\n')) // Split stanzas by empty lines
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
      });
    } catch (e) {
      debugPrint('❌ Error loading poetry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Urdu Poetry',
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown.shade900,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 24),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:
            stanzas.isEmpty
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : ListView.builder(
                  itemCount: stanzas.length,
                  itemBuilder: (context, index) {
                    final stanza = stanzas[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const RadialGradient(
                          center: Alignment.center,
                          radius: 1.0,
                          colors: [
                            Color(0xFFE0C076), // light golden center
                            Color(0xFF5D4A1F), // deep golden edge
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth = constraints.maxWidth;
                          double fontSize = (screenWidth * 0.05).clamp(
                            18.0,
                            22.0,
                          );

                          return Text(
                            stanza,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoNastaliqUrdu(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white10,
                              height: 3.0,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
 */
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_drawer.dart';

class TrackPlayerScreen extends StatefulWidget {
  final String title;
  final String imageAsset;
  final Map<String, String> artistPaths;
  final String appBarTitle;

  const TrackPlayerScreen({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.artistPaths,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TrackPlayerScreen> createState() => _TrackPlayerScreenState();
}

class _TrackPlayerScreenState extends State<TrackPlayerScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late String selectedArtist;
  List<String> stanzas = [];

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
      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() => duration = newDuration);
      });
      audioPlayer.onPositionChanged.listen((newPosition) {
        setState(() => position = newPosition);
      });
    }
    loadPoetry();
  }

  Future<void> loadPoetry() async {
    try {
      final String loadedText = await rootBundle.loadString('assets/5.txt');
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
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'ISHQ-o-MARIFAT',
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
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const RadialGradient(
                    center: Alignment.center,
                    radius: 1.5,
                    colors: [Color(0xFFE0C076), Color(0xFF5D4A1F)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Play button with rings
                    GestureDetector(
                      onTap: () {
                        if (isPlaying) {
                          audioPlayer.pause();
                        } else {
                          audioPlayer.resume();
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black87, width: 2.5),
                        ),
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black87,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 62,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Slider & durations
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12,
                              ),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.black87,
                              thumbColor: Colors.white,
                            ),
                            child: Slider(
                              value: position.inSeconds.toDouble().clamp(
                                0,
                                duration.inSeconds.toDouble(),
                              ),
                              max: duration.inSeconds.toDouble(),
                              onChanged: (value) async {
                                await audioPlayer.seek(
                                  Duration(seconds: value.toInt()),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatTime(position),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formatTime(duration),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //  const SizedBox(height: 16),
            const SizedBox(height: 5),
            Text(
              'حمدِ بے حد',
              style: GoogleFonts.notoNastaliqUrdu(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 3.0,
              ),
              textAlign: TextAlign.center,
            ),
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
                    gradient: const RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [Color(0xFFE0C076), Color(0xFF5D4A1F)],
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
                      style: GoogleFonts.notoNastaliqUrdu(
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
