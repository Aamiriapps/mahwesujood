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
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
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
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَﷲُ ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "کے سِوا کچھ نہیں جستجو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَﷲُ   اَﷲُ   اَﷲُ   اَﷲُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎  حق تعالیٰ سے خطاب",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّحْمٰنُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          " ۲؎ اب تلک ذات ہی کی سنی ہے خبر\n"
                          "بعد اسکے صفت کی ہے پھر رہ گذر\n"
                          "اک چھپے اک نظر آئے در ہر نظر\n"
                          "پوچھ رحمان کی گر ملے باخبر \n"
                          "مان رحمان کو",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "لَا شَرِیْکَ لَہُ\n"
                          "اَﷲُ   اَﷲُ   اَﷲُ   اَﷲُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۲؎ بندے سے خطاب",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّحِیْمُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          " اے مرے رحماں چھپنے والے میاں\n"
                          "جس طرح جسم میں چھپ گئی میری جاں\n"
                          "تیرے فیضان ہی سے ہے سب کچھ عیاں\n"
                          "رحم کن جانِ ما  ! شَو بمن شَو عیاں \n"
                          "جانِ ہر خوبرو    جلوہ کن    روبرو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَﷲُ   اَﷲُ   اَﷲُ   اَﷲُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمَلِکُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          " ایں ملِک ۱؎  ہست گدا آں ملِک ہست خدا\n"
                          "ایں گہے بادشاہ یا گہے خود گدا\n"
                          "اقتدارش ۲؎  بہ ہر چیز ہست برملا\n"
                          "ہر چہ خواہد     کند    در     سزا     و     جزا \n"
                          "کائناتِ جہاں ہست    در    دستِ او\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَﷲُ   اَﷲُ   اَﷲُ   اَﷲُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ مجازی تاجدار\n"
                          "۲؎ اقتدارِ حق تعالیٰ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْقُدُّوْسُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پاک ہے ذات اس کی ہر اک عیب سے\n"
                          "وہ   جو   چاہے   کرے    عالمِ غیب     سے\n"
                          "۱؎    اس پہ ایمان لا اور نکل رَیب سے\n"
                          "خوش نصیبی ملے اور بچے خَیب سے\n"
                          "تا زِ غیبش کُشا ید در خِیر اُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "ا؎ سالک سے خطاب",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "  اَلْسَّلَامُ\n",
                  style: GoogleFonts.amiri(fontSize: 40, color: Colors.white),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "اَلسَّلَامُ عَلَیکَ ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "میں کیا راز ہے\n"
                          "حق کے ملنے کی بس اس میں آواز ہے\n"
                          "کہنے والے میں پہلے وہ دمساز ہے\n"
                          "اور جوابی میں بھی وہی غمّاز ہے\n"
                          "تو ہی تو کی ہے یہ با ہمی گفتگو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُؤْمِنُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "کون دیگا ہمیں امن در دو جہاں\n"
                          "کس کو معلوم ہوگا یہ دردِنہاں\n"
                          "تو ہی مومن ہمارا یہاں اور وہاں\n"
                          "دوجہاں میں ہمیں بس ہے تیری اماں\n"
                          "امن تجھ سے ہے ملتا کہ مومن ہے تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُھَیْمِنُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تیری نگرانیوں میں رہوں میں سَدا\n"
                          "بے خبر کی خبر رکھنے والے خدا\n"
                          "تو   بچاتا    رہا    تو    میں    بچتا    رہا\n"
                          "ہوں میں اس ہَیمنت پر ہمیشہ فدا\n"
                          "اپنے کیا غیروں کا بھی مھیمن ہے تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْعَزِیْزُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "۱؎   معنٰی اک قدرت ِ حق کا بھی ہے یہاں\n"
                          "آبتاؤں    تجھے      راز        اک    میں       یہاں\n"
                          "تیرے بس میں نہیں ہے تیری کچھ اماں\n"
                          "کوئی   بچ  ہی  نہ  سکتا  یہاں یا    وہاں\n"
                          "جان لے اُس کی قدرت سے بچتا ہے تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ سالک سے خطاب",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْجَبَّارُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "فہمِ جَبَّار کو   اب سمجھ   لے    ذرا\n"
                          "تا  نہ ہو فہم میں تجھ سے کوئی خطا\n"
                          "تو جہت ظلم کی اس میں ہر گز  نہ لا\n"
                          "جبرِ خلق ہے   جُدا    اور  خدا  کا   جُدا\n"
                          "اس کی جبّاریت کو سمجھ عدل تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُتَکَبِّرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پھر تکبّر کی رہ کو سمجھ کرگذر\n"
                          "اس صفت میں نہیں ہے کسی کا گذر\n"
                          "عبد کرتا ہے   تو   ہے  خطا سربسر\n"
                          "وصفِ ابلیس میں غور سے کر نظر\n"
                          "۱؎    کبِریائی    یقیناً         سزاورِ     اُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ حق تعالیٰ کی طرف اشارہ ہے",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْخَالِقُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "عالمِ خلق ہے روبرو      ہی  ترے\n"
                          "سب زمیں آسماں کے ہیں دفتر کُھلے\n"
                          "چاند سورج ستارے چمکتے ہوئے\n"
                          "بحرو بر ہیں ہزاروں ہیں  آئے گئے\n"
                          "خلق    آئینہ ء  خالق ست اے کُفو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَارِئُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "باری ایسی صفت کو تو بس جان لے\n"
                          "جس میں نسبت نہیں اس کو پہچان لے\n"
                          "قد رتِ حق کو بالکل یہاں مان لے\n"
                          "آدم   و حوّا     عیسیٰ کو تو جان لے\n"
                          "بے پدر جلوۂ حق رہے روبرو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُصَوِّرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اس کی صورت گری سے ہے صورت بنی\n"
                          "یعنی بے صورتی کی ضرورت بنی\n"
                          "جلوہ ہائے دو عالم کی صورت بنی\n"
                          "صورتِ آدمی جیسی مورت بنی\n"
                          "ورنہ ہوتے کہاں یہ حسیں ماہرو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْغَفَّارُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "مغفرت کے لئے اس کا در ہے کُھلا\n"
                          "اے گنہگا ر تو   در   بدر  کیوں   چلا\n"
                          "آ    سُنا   اس کو تو جو ہوئی ہے خطا\n"
                          "سر جھکا             گڑ گڑا      ،       آہ   کر  تلملا\n"
                          "بول غفّار تو       اور      ستّار     تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْقَھَّارُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "قہر ۱؎   سے اس کے کوئی نہیں بچ سکا\n"
                          "ہوکے مقہور   رہ    جائے شاہ   و   گدا\n"
                          "اس کی قہّاریت  کا   عجب   دبدبہ\n"
                          "کیا بچے   گا   بچائے   گا  کوئی    گدا\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَالَا ماں اَلَاماں ",
                      style: GoogleFonts.amiri(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "  کی ہے بس گفتگو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ جب اس نے قہر و عتاب نازل فرما\n"
                          "نے کا فیصلہ فرمادیا \n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَھَّابُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "بے طلب بے کسب جو مِلا یا ملے\n"
                          "وصفِ  وہّاب  کے  ہم کو  صدقے ملے\n"
                          "سارے   اعضاء   ملے  اور   دل  و  جاں ملے\n"
                          "وصف ِ  وہّاب ہی کے ہِبے   ہیں ملے\n"
                          "ہم عدم تھے! کیا  جس نے موجود   تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّزَّاقُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "سارے عالم کی روزی   ترے  در  سے  ہے \n"
                          "بھیک شاہ  و  گدا   کو   ترے   گھر  سے ہے\n"
                          "نہ  کسی    زور   سے  نہ کسی  زر   سے   ہے\n"
                          "نہ عرض سے ہے کچھ اور نہ جو ہر سے ہے\n"
                          "دینے   والا   تو  ہی  لینے والے سبھو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْفَتَّاحُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "فتح   و  نصرت  کے در ہیں تجھی  سے کھلے\n"
                          "بند تھے سارے ، جب تو نے چاہا کھلے\n"
                          "تو   اگر    بند کر دے   تو پھر کیا ملے\n"
                          "کھول فتّاح ِ عالم !ہمیں کچھ ملے\n"
                          "بند کرنے میں تو کھولنے میں بھی تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْعَلِیْمُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "جہل بس ہم میں ہے علم سب تجھ میں ہے\n"
                          "اعلم جو ہے وہ ہم سے نہیں تجھ سے ہے\n"
                          "بے  خبر  کو   خبر    بالیقیں    تجھ    سے     ہے\n"
                          "ظلمتیں ہم سے ہیں نور سب تجھ سے ہے\n"
                          "بے خبر کی خبر کے لئے بس ہے تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْقَابِضُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تیرے  قبضے سے باہر نہ کوئی رہا\n"
                          "تیرے  قبضے میں سب اور تو ہی ہے خدا\n"
                          "تیرے قبضے میں ہے سارا عالم گدا\n"
                          "تو  جو  چاہے   وہ  ہو   اور  جو   چاہا    ہوا\n"
                          "اس   لئے    بیکسوں    کا  مددگار       تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَاسِطُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "یَقبِضُ      یَبسُطُ",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          " تیرے     افعال       ہیں\n"
                          "۱؎     ہم سے کیا ہو سکے ہم تبہ حال  ہیں\n"
                          "  تیرے قبضے میں",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَنفُس ",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "      ہیں اَموال ہیں\n"
                          "     سب  مشیّت    تری    ہم  تو   پا مال  ہیں   \n"
                          "قبض میں بھی ہے تو بسط میں بھی ہے تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْخَافِضُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پست کردے جسے چاہے  اور خستہ حال\n"
                          "تیرے    آگے     کسے    گفتگو   کی   مجال \n"
                          "جھکنے   والے  کو  جھکنے میں کیا ہو ملال\n"
                          "تیرے   آگے سبھی جھک گئے   ذوالجلال\n"
                          "ہم تو سب  جھک گئے  اب  اٹھائے   تو تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّافِعُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو جسے چاہے کردے   بلند  اے  خدا\n"
                          "ہم سے کیا ہو سکے جب کہ ہم ہیں گدا\n"
                          "تیری رفعت پہ صدقے ہوں شاہ   و  گدا\n"
                          "تن  فدا  من   فدا  جانِ جاں  سب  فدا\n"
                          "تیری رفعت کو جانے تو بس تُو ہی تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُعِزُّ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "تو",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "ّ مُعِز ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "حقیقی    ہے   عزّت        تری\n"
                          "جس کو چاہے تو کردے عطا  برتری\n"
                          "تیرے بِن  ہم میں کچھ بھی نہیں بہتری\n"
                          "ذِلتو ں میں ہیں ہم تجھ سے ہے سروری\n"
                          "تُو    ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "مُعِزِّ ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "حقیقی      ہے      تجھ  میں  علُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُذِلُّ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "ہے ",
                  style: TextStyle(
                    fontFamily: 'Alvi',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "مُذِلِّ ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "تو یقیں ذلّتوں  سے  بری\n"
                          "ذات میں تیری بالکل نہیں کمتری\n"
                          "غیر تیرا   کرے  کیا    تری   ہمسری\n"
                          "ہم میں عزّت تری   ورنہ  ذلت بھری\n"
                          "عزّتیں ہیں تری ،عزّتوں  میں  ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلسَّمِیْعُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو  ہے  شنوا    یقیناً سمیع  ہم نہیں\n"
                          "تو سنے  ہم  سنائیں  تو  کچھ غم نہیں\n"
                          "تجھ  سا  شنوا   ملے  تو  ہمیں کم نہیں\n"
                          "ماسِوا  تیرا  کیا  سن  سکے  دم  نہیں\n"
                          "ہم سنائیں  تجھے  اور  شنوا  ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَصِیْرُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہے بصارت  تری  اور  ہم  بے  بصر\n"
                          "دید  تیری   یقینی  ہے  ہم  بے  نظر\n"
                          "یہ نظر بھی تو   نابینا  ہے  سر   بسر\n"
                          "تیری  بینائی  میں  کب  کسی  کا  گذر\n"
                          "دیکھتا بھی ہے  تو   اور  دکھاتا  بھی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَکَمُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو   حَکم  ہے  ترا   فیصلہ بھی حَکم\n"
                          "تیرے  آگے  سبھی   ہیں   یقیناً   عدم\n"
                          "فیصلے  میں  ترے  کون  مارے    گا    دم\n"
                          "کس کو  دم  تو  قِدم   ہے  یقیں  ہم  عدم \n"
                          "تو حَکم  ہے  حقیقی   خدائے   عَفو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْعَدَلُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو عدل  تیرا     انصاف  ہے  سب اٹل\n"
                          "ظلم سے    تو      بری  ہے  ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: " اَعَز ّ  و    اَجَل\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "فضل یا عدل کرتا  ہے  تو   اے  عدل\n"
                          "فضل ہے سر بسر ہم میں کیا ہے عمل\n"
                          "عدل میں بھی ہے تو فضل میں بھی ہے تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَللَّطِیْفُُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "لطف تیرا    ہر  اک  پر  ہر اک آن ہے\n"
                          "تیرے  الطاف  سے  جسم  میں جان ہے\n"
                          "منکرِ لطف ہے  تو  وہ  شیطان  ہے\n"
                          "تیرے  الطاف  ہیں  اور تو   رحمان  ہے\n"
                          "ہے لطیف  و   لطافت  بھی  لطف  بھی تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْخَبِیْرُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو   خبیرِ  دو   عالم  ہے  ہم  بے  خبر\n"
                          "ذرّہ    ذرّہ   کی تجھ کو ہے  ہر  دم  خبر\n"
                          "کوئی  ہو  در  سفر یا  کوئی  در  حضر\n"
                          "سارا   عالم   ترے  علم میں محتضر\n"
                          "ہے خبیرِحقیقی   تو   بس  تُو  ہی  تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَلِیْمُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "بُرد  باری   تری  کوئی   کیا  جانتا\n"
                          "حِلم  تیرا  کوئی  کب  ہے   پہچانتا\n"
                          "منکرِحق   ہے  جو  پھر  نہیں  مانتا\n"
                          "پھر بھی  در سے  تُو   اُس کو نہیں  راندتا\n"
                          "مقتدر   ہوکے  بھی  ہے  حلیم  ایسا تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْعَظِیْمُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہے  بزرگی  میں  یکتائے  عالم  تو  ہی\n"
                          "سب حقیر  و    ذلیل   اور    اعظم  تو   ہی\n"
                          "خالقِ    جز   و   کُل  رَبّ ِ   آدم   تو      ہی\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "حَا کِم   ُ الحَکُمَاء ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "اور    اَحکَم  تو      ہی\n"
                          "ہے عظیمِ دو عالم  بھی  عظمت بھی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْغَفُوْرُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پھر دوبارہ     درِ مغفرت کھل گیا\n"
                          "اس کو سن کر مرے صدر  سے  دل گیا\n"
                          "میں  ملا   تو نہیں  وہ  مجھے  مِل  گیا\n"
                          "دل جگر میرے سینے میں بس ہل گیا\n"
                          "ہے غفوری   تری  مغفرت میں  ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلشَّکُوْرُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "شاکروں  کی  تو  ہی  قدردانی   کرے \n"
                          "ناقصوں    پر  بھی  تو   مہربانی   کرے\n"
                          "فعلِ محبوب  کو    جاودانی    کرے\n"
                          "اس کو بھی دے  جزا  جو  زبانی  کرے\n"
                          "ہے شکور ِحقیقی   شکور     ایسا         تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْعَلِیُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو بلند  اور   برتر     تری    ذات   ہے \n"
                          "سب سے اعلیٰ و افضل تری ذات ہے\n"
                          "تو  رفیع     المراتب     و     درجات     ہے \n"
                          "سب میں ہوتے ہوئے بھی الگ ذات ہے\n"
                          "ہے   عُلو   مرتبت     اور     بلند ی   بھی    تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْکَبِیْرُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہے   کبیری   تری    کبریائی   تجھے\n"
                          "سب ہیں  تیرے گدا      اور    خدائی تجھے\n"
                          "۱؎      اکبریت  کی  شاں سب   سہائی  تجھے\n"
                          "تجھ سے  ادنی ٰ  ہیں  سب ہے  بڑائی تجھے\n"
                          "ہے   بڑے  سے   بڑا       اور   بڑائی میں تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "  ۱؎ حضرت مصنف دامت برکاتہم نے قصداً \n"
                          "مقامی زبان استعمال کی ہے\n"
                          "  ہماری طرف سہانا زیب دینے کے \n"
                          "معنوں میں بولا جاتا ہے\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَفِیْظُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "حفظ  تیرا   ہر  اک  طور  ہر   آن  ہے\n"
                          "تو    نظامِ   جہاں    کا    نگہبان   ہے\n"
                          "ہر طرح سے ہمیں تیرا    حفظان ہے\n"
                          "ہر  بلا   سے   بچائے   تو    نگران   ہے\n"
                          "ظاہراً    باطناً     ہے   حفیظ     ایسا      تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُقِیْتُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "بس سبھی کو کِھلاتا    پِلاتا   ہے  تو\n"
                          "رزق  دے  کر یقیناً    جِلاتا   ہے   تو\n"
                          "نہیں  بھو کا   کسی  کو   سُلا تا    ہے تو\n"
                          "اور  مقیتِ  دو  عالم  کِھلاتا  ہے  تو\n"
                          "ہے    مقیتِ   حقیقی   تو        رز ّا ق    تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَسِیْبُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "حَسبُنا اللہ ُ ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "کی  بس ہمیں  اک  صدا\n"
                          "کم  نہیں  یہ  کرم   کم  نہیں  یہ  عطا\n"
                          "دو جہاں لے کے بھی کیا کریگا   گدا\n"
                          "وہ   اگر    مل  گیا  تو  ہو   اس  پر فدا\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "مَن تَوَکَّل     عَلیَ   اللّٰہ  ھُوَ     حَسْبُہ‘    \n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْجَلِیْلُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہے  جلالت   تری  تو  ہے  ربّ ِ   جلیل\n"
                          "تیرے   آگےسبھی  ہیں  حقیر   و     ذلیل\n"
                          "ذوالجلالی      تری    شان   ہے  اے جمیل\n"
                          "تیری  جاہ    و   جلالت  ہے بس بے مشیل\n"
                          "ہے  جمال   و    کمال   و     جلالت    میں  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْکَرِیْمُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اے  کرم  کرنے  والے  کرم کر   ذرا\n"
                          "ہم ٖ غریبوں  کی  سن  اے  کریم   اب  دعا\n"
                          "اب  تلک  صدقہ  تیرے  کرم      کا      ملا\n"
                          "تیرے     ملنے     کا      اک    رہ     گیا     مدعا\n"
                          "بس کرم   اتنا  ہو  کہ  ملے  ہم  کو تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّقِیْبُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو    نگہبان  ہے  تو  سب    آسان   ہے\n"
                          "ورنہ  سارا   جہاں  بس  ہر اسان    ہے\n"
                          "یہ   رقیمی  تری   ہم  پہ   احسان   ہے\n"
                          "بس  یہی  امن  ہی  ساز   و    سامان  ہے\n"
                          "تو   نگہباں  ہے  جب  کیا  ہو  خوففِ  عدو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُجِیْبُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو      مُجیب ِ  حقیقی       دعاؤں     کا       ہے\n"
                          "بے کسوں کی پکاروں   صداؤں  کا  ہے\n"
                          "سننے  والا    امیروں  ، گداؤ ں  کا   ہے\n"
                          "دور  و   نزدیک  کی  سب  نداؤں   کا   ہے\n"
                          "میری  بھی  سن  دعا   سننے   والا  ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَاسِعُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تجھ سا   واسع  کوئی  بھی  نہیں  اے  خدا\n"
                          "وسعتیس  تجھ  میں  ہیں  اور  تو  دے  رہا\n"
                          "تجھ  میں  تنگی  نہیں  نام  کو  بھی    ذرا\n"
                          "گر  تو   چاہے   جہاندار     ہو   بے     نوا\n"
                          "وسعتوں میں بھی تو    اور      واسع   بھی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَکِیْمُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "حکمتیں تجھ  سے  ہیں  تو  حکیم ِ  جہاں\n"
                          "تیری حکمت  سے  روشن  ہے  سارا    جہاں\n"
                          "بر  عقول    ِ جہاں     ہست       پر    تو          فشاں\n"
                          "ہست   از   تو   علوم      و      عقول ِ    جہاں\n"
                          "سب حکیممِ    مجازی     ،    حقیقی     ہے    تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَدُوْدُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو   ودود    و     ولی    اور  موَدَّت   میں  تو\n"
                          "ہے    محبِّ ِ   حقیقی     ، محبت     میں     تو\n"
                          "جلوہ فرما ہے رحمت میں چاہت میں تو\n"
                          "ہے   ودودِ  جہاں لطف   و   رافت میں تو\n"
                          "عاشقوں  میں  تجھی  سے ہے یہ رنگ  و  بو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمَجِیْدُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہے  بزرگی  تو  تیری  تجھی  میں   رہے\n"
                          "وہ جو تجھ سے ملے اس کو بھی کچھ ملے\n"
                          "جس طرح ہے مہک گل کی   اوپر   تلے\n"
                          "اصل  گل  کی ہے  اور  فرح  سب  کو ملے\n"
                          "مجد   تیرا   مجید ِ  دو      عالم     ہے       تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَاْعِثُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "سلسلہ     بعثت ِ       انبیا ء      کا          رہا\n"
                          "بعثت ِ  انبیا ء  میں  تو   باعث  رہا\n"
                          "سارے آئے  نبیؐ    ختم  بھی    ہوگیا\n"
                          "بعدِ موت  ایک   وعدہ   رہا    بعث  کا\n"
                          "باعثی    ہے  تری ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "‘لَا   شَرِیْکَ لَہ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلشَّھِیْدُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تجھ سا کوئی  گواہ    ہی  نہیں   اے   خدا\n"
                          "عین ِ    مشہود      تو   ،تو    ہی    شاہد     رہا\n"
                          "دیکھتا   بھی     رہا     اور    دکھاتا     رہا\n"
                          "تجھ سے کوئی چھپا  اور   نہ  کوئی جدا\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "وَالشَّھِیْدُ ھُوَ الشَّاھِدُ یَشْھَدُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَقُّ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "توہے حق   اور  تیری  رضا  بھی ہے حق\n"
                          "تیرا    ہر  فعل  حق  فیصلہ  بھی   ہے   حق\n"
                          "تیری  تنزیل   کا  سلسلہ  بھی  ہے   حق\n"
                          "دعوتِ    سرورِ     انبیاء  بھی  ہے  حق\n"
                          "حق ہے تو حق ہے تو حق ہے تو حق ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَکِیْلُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "کام  تجھ  سے  بنے  اور   بنا تا  ہے  تو\n"
                          "بگڑی  بن  جاتی  ہے  جب  بناتا   ہے  تو\n"
                          "حُسن  کی  منزلیں  سب  سجاتا  ہے  تو\n"
                          "مرنے  والے  جئیں  جب  جِلاتا  ہے  تو\n"
                          "کارسازی  میں  تو  رہبری  میں  بھی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْقَوِیُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تیری قوت سے فاعل بنیں  دو  جہاں\n"
                          "سب  ضعیف  اور  تو   اک  قوی  بے  گماں\n"
                          "ایک   جنبش  نہ  ہو  جن  سے  وہ   ناتواں\n"
                          "تیرے در سے ہی پاتے ہیں تاب و تواں\n"
                          "بالیقیں   ہے    قوی    بے    گماں   تو   ہی    تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمَتِیْنُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہے  متانت  تری  تُو  تو  تھکتا  نہیں\n"
                          "بِن  چلائے  ترے  کوئی  چلتا   نہیں\n"
                          "تو   چلائے  تو  کوئی  ٹہرتا  نہیں\n"
                          "او  متینِ    دو     عالم   تو   گھٹتا   نہیں\n"
                          "ہے  قوی  و  متین  اے  خداوند   تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: " اَلْوَلِیُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "دوستی  ہے  تری  جب  کسی  کو   ملی\n"
                          "اس  کو  حاصل  ہوئی  ہے  مرادِ   دلی\n"
                          "اس سے بڑھ کر نہیں ہے کوئی بہتری\n"
                          "تو   ولی  اس  کا   اور  وہ  ہے  تیرا   ولی\n"
                          "کیا کرے اس  سےبڑھ کر کوئی   آرزو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَمِیْدُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہر طرح   حمد   تجھ  کو  سزاوار  ہے\n"
                          "ہر ستائش  کا  بیشک  تو  حقدار  ہے\n"
                          "تجھ  پہ  قرباں  مرا    سارا  گھر  بار   ہے\n"
                          "لائقِ   حمد  بس   تیرا     دربار    ہے\n"
                          "لائقِ   حمد  تو   مالک ِ    حمد   تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُحْصِیُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تیرے احصاکے گھیرے میں سب گِھیر گئے\n"
                          "۱؎    سر جھکائے ہوئے سب کے سب گرگئے\n"
                          "پھر اُٹھیں کس طرح سب کے سب جب سرگئے\n"
                          "تجھ سے سب مل گئے خلق سے پھر گئے\n"
                          "سب   کا   محصی   ہے بس  خالق ِ   خلق    تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ یہ احوال و مواجید ہیں ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "  اَلْمُبْدِئُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ابتدا ءً      تو    پیدا  کرے   بے   مثال\n"
                          "کس کو ہے   ایسی قدرت  کسے  ہے  مجال\n"
                          "یہ   ہے    اِبدا        ترا      اور     تیرا     خیال\n"
                          "اس طرح  تو  دکھاتا  ہے  اپنا  کمال\n"
                          "سارے عالم کا مبدئ ہے بس ایک تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُعِیْدُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پھر  اعادہ  کرے  تیری  وہ    شان  ہے\n"
                          "لوٹ  کر  آئے   ہر  شئے  وہ   فیضان  ہے\n"
                          "یہ  نہ  ہو  تو  جہاں  سارا   ویران  ہے\n"
                          "یہ  تجلی  ہر  اک دم   ہر  اک  آن  ہے\n"
                          "ہے  مُعیدِ    حقیقی      تو    ہی",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "‘وَحْدَہ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُعْیِ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "سارے عالم کو تجھ سے ملی زندگی\n"
                          "تیرے    اِحیاء  کی سب میں ہے  تا بندگی\n"
                          "زندگی   دی   ہمیں   تا   کریں   بندگی\n"
                          "بندگی  جب  نہیں   زندگی    مردگی\n"
                          "زندگی  دینے  والے  محی  ہے  تو  تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُمِیْتُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "مارنے  میں  ترا  کس  طرح  نام  ہے\n"
                          "موت  تجھ  میں  نہیں  تو  یہ  کیا    کام  ہے\n"
                          "موت بھی تیری جانب سے انعام ہے\n"
                          "زندگی   سلب   کرنا    ترا    کام    ہے\n"
                          "مرنے  والا  مرا     اس  میں  کیا  گفتگو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْحَیُّ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "جینے  والے  تری  زندگی   کی   قسم\n"
                          "زندگی  ہے  تری  زندہ  تو   مردہ   ہم\n"
                          "جوں کی توں ہے تری  زندگی  کچھ  نہ کم\n"
                          "تو سلامت ہے تو پھر ہمیں کیا ہے غم\n"
                          "مردہ ہم ،زندہ تُو، زندگی میں بھی تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: " اَلْقَیُّوْمُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو ہے  قائم  بخود   تجھ  سے  قائم  ہیں  ہم\n"
                          "تُو    وجودِ    حقیقی   ہے   ہم   ہیں   عدم\n"
                          "تیرے صدقے میں آئے بہ سوئے   قِدم\n"
                          "تُو   قِدم   ہم   عَدم  کیا  رہے  ہم  میں  دم\n"
                          "تصدقے  جائیں  قیام  و   بقا    میں  ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَاجِدُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "سب کو  موجود  کرنا   ترا   کام   ہے\n"
                          "پھر   وجوداً    ترا  سب  میں   اِقدام  ہے\n"
                          "عالم ِ  خلق    پر    تیرا          اِکرام     ہے\n"
                          "اور   عدم   پر  یقیناً     یہ    انعام  ہے\n"
                          "تُو  ہے  واجد  یقیناً  ہے  موجود    تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمَاجِدُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ر جہت سے بزرگ  اور  بزرگی  میں  تو\n"
                          "مجد   و      امجد   و       ماجد    مجیدی    میں    تو\n"
                          "حمد    و     احمد    و     حامد     حمیدی  میں  تو\n"
                          "اکرم      الاکرمیں      اور  کریمی  میں  تو\n"
                          "ہم سے کیا ہو بھلا ہم نہیں سب ہے تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَاحِدُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "تو   اکیلا  ہے  ساتھی  کوئی  بھی  نہیں\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "لَاشَرِیکَ لَہ‘",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "میں نبیؐ بھی نہیں\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "َا اِلٰہ‘",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "کہا  تو    ولی   بھی   نہیں\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "وَحدَہ‘",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: " کہدیا    تو  کوئی  بھی نہیں\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "وَحْدَہ‘ لَا شَرِیْکَ لَہ‘  ‘",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: " تو   ہی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْاَحَدُ\n",
                  style: GoogleFonts.amiri(fontSize: 38, color: Colors.white),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "۱ ؎   احدیت  میں  ھُوَ کے  سِوا  کیا  رہا\n"
                          "نہ   اَنا   ہی   رہا   اور   نہ   اَنتَ   رہا\n"
                          "احدیت  میں  ھُوِیَّت  کا  غلبہ  رہا\n"
                          "خود  صفات  و     انا  سے  بھی   پردہ   رہا\n"
                          "اس طرح ذات میں  مختفی ھُو ہی ھُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ مُنقطع الاشارات",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلصَّمَدُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تجھ کو  پرواہ   کسی  کی  نہیں  بالیقیں\n"
                          "سب  ہیں  محتاج  تیرے  مگر  تو   نہیں\n"
                          "تجھ  کو  حاجت  کسی  امر   کی   ہی  نہیں\n"
                          "تجھ   کو    کیا   حاجتِ     آسماں  و    زمیں\n"
                          "لامکاں  کا   مکیں  ہے  تو  بس  تو  ہی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْقَادِرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تیری  قدرت  میں کیا   ہے کمی  اے  خدا\n"
                          "کُن   سے   بس   فَیَکُوں    ہے   ترا     فیصلہ\n"
                          "تیرا     چاہا    ہی   ہو   تیرا     چاہا    ہوا\n"
                          "میری سننے میں تجھکو  رکاوٹ  ہے  کیا\n"
                          "میرا   مالک  ہے  تو  میرا    قادر  ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُقْتَدِرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اقتدارِ   حقیقی    ترا        اے      خدا\n"
                          "مقتدر تو ہے  اور   ماسِوا   سب  گدا\n"
                          "دم   نہ   مارے   کوئی  باشاہ    و    گدا\n"
                          "تو جو چاہے وہی   ہوگا    بس  فیصلہ\n"
                          "ہے   رضا   بر    قضا   میں   مری    آبرہ\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُقَدِّمُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تیری   تقدیم  سے  سب  مقدم   ہوئے\n"
                          "جتنے   آگے   بڑھے   وہ   معظم  ہوئے\n"
                          "دین  کی  دی   کرامت  مکرَّم    ہوئے\n"
                          "جس کو   دی  حرمتیں  وہ  محرَّم  ہوئے\n"
                          "ساری   تقدیم  تیری   \n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "مُقَدِّم",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "ہے   تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُؤَخِّرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "جن  کو   پیچھے  کیا   وہ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "مُؤَخَّر",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "ہوئے\n"
                          "    ہر عمل میں گھٹے    وہ ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "مُحَقَّر   ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "ہوئے\n"
                          "ان کے قلب  اور  روح  سب  مکدّر ہوئے\n"
                          "اِقتضا   ان  کی تھی  جو  مقدّر  ہوئے\n"
                          "یہ  ہے  تاخیر  تیری",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "مُؤَخِّر",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "ہے   تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْاَوَّلُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "سب سے اول ہے تو کوئی تجھ  سا  نہیں\n"
                          "بعد  تیرے   ہیں  سب  کوئی  پہلا  نہیں\n"
                          "خوبیوں    میں   ترا   کوئی   ہمتا   نہیں\n"
                          "تجھ سے  اعلیٰ   و    افضل  و   اولیٰ   نہیں\n"
                          "سب خدائی سے اوّل ہی اوّل ہے تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْا ٰخِرُ \n",
                  style: GoogleFonts.amiri(fontSize: 40, color: Colors.white),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تجھ  بِن   آخر  تو  کوئی  بھی  نہ  رہ   سکے\n"
                          "تو   رہے     اور  بس   نام  تیرا    رہے\n"
                          "خود    ",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "  ھُوَا لا ٰخِرُ",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اکا    نظارہ    کرے\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "وَحْدَہ‘ لَا شَرِیْکَ لَہ‘  \n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "  خود  کہے\n"
                          "خود   اکیلا   کہے   جائے   گا     اللہُ ُ\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلظَّاھِرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو ہے ظاہر ،جہاں تیرا مظہر ہے سب\n"
                          "دیکھنے کی نظر ہے تو منظر ہے سب\n"
                          "رب کا جلوہ تعیُّن کے اندر ہے سب\n"
                          "آنکھ والوں کو محشرہی محشر ہے سب\n"
                          "حق بہ صورتِ شئے ہے",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: " ھُوَ الظَّاھِرُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَاطِنُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ظاہری  میں بھی تو پھر چھپا بھی ہے تو\n"
                          "ظاہر ا بھی ہے تو   پوشیدہ   بھی  ہے تو\n"
                          "کیا   کہوں   شاہد ِ   اَینَمَا    بھی  ہے  تو\n"
                          "جلوہ  گر  ہے  خودی   میں ،خدا  بھی ہے تو\n"
                          "ظاہراً      باطناً        بس        وجوداً         ہے     تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَالِیُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "والی  اس  کے  سِوا  ہے  کوئی بھی  نہیں\n"
                          "سر   پرستی    کسی  کی   ذری   بھی   نہیں\n"
                          "۱؎    جوں  کی توں ہے  ولایت  سری  بھی  نہیں\n"
                          "خلق  کو  دعوئی    ہمسری  بھی  نہیں\n"
                          "اس   ولایت   کا   والی   فقط  تو  ہی   تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ \n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text:
                          "━━━━❀❀❀━━━━\n"
                          "۱؎ حضرت مصنف دامت برکاتہم نے\n"
                          "قصداً مقامی زبان استعمال کی ہے \n"
                          "مستحن اقدام نشاند ہی کرتا ہے کہ\n"
                          "اُردو پر اہلِ جنوب کا بھی حق ہے     یہ\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُتَعَالِیُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "حق تعالیٰ  ہے  تو    اور  تعالی  تری\n"
                          "سب  سے برتر  ہے  تو  مُتَعالی   تری\n"
                          "ہے   بلند   مرتبت    شانِ    عالی   تری\n"
                          "بس  یقیناً   ہے  یہ   ذوالجلالی    تری\n"
                          "ہے  بلند  تو   ہی  تو  ہے  بلند  تو  ہی  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَرُّ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "تو    نکو کار  ہے   ہم   تو   بدکار   ہیں\n"
                          "تیری نیکی سے ہیں  جو  نکوکار   ہیں\n"
                          "رو  سیاہی  سے  ہم  موجبِ   نار  ہیں\n"
                          "نیک تر تو ہی ہے ہم گنہ گار ہیں\n"
                          "بدہماری صفت اور برّ  ہے تو   تُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلتَّوَابُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اس  کی   تو ّابیت    کا   کھلا    در   ملا\n"
                          "در   ملا   تو  سمجھ  خود   بخود   گھر  ملا\n"
                          "اس نے دعوت ہے دی تجھ کو    اب بر ملا\n"
                          "اس   بہانے   سے   اللہ ُ    اَکبر    ملا\n"
                          "کرلے تو بہ اسی میں ہے بس   آبرو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُنْتَقِمُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "منتقم کو سمجھ کر بھی کر   ذکر  تو\n"
                          "کر  تکبر   کے معنی ٰ   میں پھر  فکر  تو\n"
                          "تا   بچے    از    قباحاتِ     ہر   کِبر    تو\n"
                          "صبر کر شکر کر  ذکر  کر  ذکر تو\n"
                          "بدلہ لیتا ہے حق اس میں کیا گفتگو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْعَفَوُّ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "مغفرت میں گنہ بخش دیتا ہے وہ\n"
                          "عفو میں تجھ  سے بدلہ نہ  لیتا ہے وہ\n"
                          "پھر زیادہ تجھے خود سے دیتا ہے وہ\n"
                          "بعدازاں کچھ  نہ پھر  تجھ سے لیتا ہے وہ\n"
                          "اس لئے نام اس نے رکھا ہے عفُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّؤُوْفُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "بزم میں اپنی رافت کا چرچا رہا\n"
                          "اصلی حق  کا  تو   ظِلّی   انہیں  کا  رہا\n"
                          "سہرا    اس  کا  محمدؐ  کے  سر کا  رہا\n"
                          "چار سو  جن  کا  پر چم  ہے  لہرا  رہا\n"
                          "شد  رَؤوْفٌ   رَّحِیْمْ  ہمچناں   اسمِ  او\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: " مَالِکَ الْمُلْکُ\n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "مَالِکُ المُلک  وہ ہے  اور  اسکا ہے  سب\n"
                          "باشاہِ   حقیقی     کا    قبضہ   ہے   سب\n"
                          "اپنے قبضہ میں اشیا  وہ   رکھتا  ہے سب\n"
                          "بس  وجوداً    خدا   کا   احاطہ  ہے  سب\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "لَاشَرِیْکَ لَہ‘ وَلَہ‘ مُلکہ‘\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "ذَالْجَلَالِی وَالْاِ کْرَامُ\n",
                  style: GoogleFonts.lateef(fontSize: 40, color: Colors.white),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ذُوالجلالی    والاکرام  کیا   شان  ہے\n"
                          "اقتدار ِ  حقیقی     کا    اعلان   ہے\n"
                          "ہر  جلالی   تجلّی  کا   سامان  ہے\n"
                          "سارے  اسما   جلالی  کا  عنوان  ہے\n"
                          "چوں جلالت صفت و جلیل اسمِ او\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُقْسِطُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پھر عدَل  اور  مقسط  میں  گہرا  ہے  فرق\n"
                          "عدل   میں   فیصلہ  ہے    بانداز ِ    حق\n"
                          "اس  میں   اِقساط  و    انصاف  و    اِمداد   حق\n"
                          "تا   رساند     خدائم    بہ     حقدار   حق\n"
                          "زیں  وجہ  تو   بخوانیش  یا  مُقسِطُ\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْجَامِعُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اِنَّہ‘ یَجْمَعُ کُلَّ شَئٍ ھِنَا\n"
                          "یَحْشُرُ کُلَّ شَئٍ فَبَعْدَ الْفَنَا\n"
                          "یَجْمَعُ الْجَامِعُ کُلَّ اَجْزَائِنَا\n"
                          "یَفْعَلُ ھٰکَذَا جَامِعاً رَبُّنَا\n"
                          "فَا ذْکُرُوْہ‘ وَ قُولُوْا    لَہ‘ جَامِعُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْغَنِیُّ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "کُلَّنْا الْفُقَرَاءُ   وَ   اَنتَ الْغَنیِ\n"
                          "وَلَکَ الْکِبْرِیَآءُ  وَ  اَنْتَ الْغَنیِ\n"
                          "فَالعُلُوُّ لَکَ مَا سِوَاکَ الدَّنیِ\n"
                          "فَاذْکُرُوہ‘ وَ قُولُوا لَہ‘ یَا غَنیِ\n"
                          " اَیُّھَا الْفُقَرَآءُ فَقُو لُوا لَہ‘\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمُغْنِیُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اِن ذَکَرتَ اسمُہ‘ یَاغَنِی یَا غَنِی\n"
                          "ثُمَّ قُلْتَ لَہ‘ اَلْفَقِیر اِنَّنِی\n"
                          "وَشَکَرتَ لَہ‘ تَذکُرُ یَا غَنِی\n"
                          "اِنَّنِی اَلْفَقِیرُ وَ اَنْتَ الْغَنِی\n"
                          " رَبُّنَا مُغْنِی وَ الْعَالَمُ عَبدُہ‘\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْمَانِعُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اِنَّکَ تُعْطِنَا مَا تُرِیْدُ لَنَا\n"
                          "نَا خُدُ مِنْکَ یَا رَبَّنَا کُلَّنَا\n"
                          "اِن مَّنَعْتَ فَلَا یُعْطِی اَحَدٌ لَّنَا\n"
                          "فِی الْعَطَا نَحْنُ مِنْکَ وَ مِنَّا الْفَنَا\n"
                          "وَلِذَا اِنَّکَ الْمُعْطِیُ الْمَانِعُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلضَّآرُّ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اَلْمُضَرَّۃُ لَا تَاتِی مِن غَیرِہٖ\n"
                          "لَا یُخَالِفُنَا الْخَلْقُ مِن غِیرِہٖ\n"
                          "لَا یَصِل شَئٌ مِّن شَرِّہٖ خَیرِہٖ\n"
                          "لَا یُخَالِفُنَا شَئٌ مِّن ضَیرِہٖ\n"
                          "فَا د عُہ‘ بِاسمِہٖ اِنَّہ‘ الضَّآرُّ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلنَّافِعُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Majeed',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "وَھُوَ النَّافِعُ نَفْعُہ‘ عِنْدَہ‘\n"
                          "     اِن اَرَدتَّ النَّفَعْ فَاَرِد عِنْدَہ ‘\n"
                          "   اِنَّہ‘ لَیْسَ بِمُخْلِفٍ  وَّعدَہ ‘\n"
                          "   مِنْہ‘ یَاتِیکَ نَفْعُکَ یَا عَبدَہ ‘\n"
                          "  فَا طْلُبُوا النَّفْعُ قُولُوا لَہُ النَّافِعُ  \n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلنُّورُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "نورِمطلق   خدا   بعد  ازاں  مصطفیٰؐ\n"
                          "بعد   ازاں    نور    آمد   کتابِ   خدا\n"
                          "از   احادیثِ   او   نور   یک   ظاہرا\n"
                          "بعد    ازاں   فقہ   آمد و  شد  مقتدا\n"
                          "بعد  ازاں  نورِ  عرفاں  بود  نورِ اُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْھَادِیُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "ہادی  است  بے گماں خالقِ دوجہاں\n"
                          "شد    مزیّن   ازو       کائناتِ     جہاں\n"
                          "بعد ازاں ہست ہُدائے شہِ  انس  و  جاں\n"
                          "اُو   نماید   ہمہ  کنہِ  کون   و    مکاں\n"
                          "ہست    ہادی    نبیؐ    از     خداوندِ    اُو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَدِیْعُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "آفریدنِ  حق  بے    مثال    آمدہ\n"
                          "اَوَّلا ً       پیدا     کر دہ     ہمہ  خلق      راـ\n"
                          "  بعد ازاں  صورتش    را      اعادہ    شدہ\n"
                          " گشت بدیع  او  سماوات   و   الارض    را\n"
                          "      پس  بداں   ایں  کمال ِ   خداواندِ    تو،\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْبَاقِیُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "پس  بقا    مطلقاً   ثابت    است   از   خدا\n"
                          "    ما سِوا  مطلقاً    فانی     است    و    گدا\n"
                          "   از     خدا        آمدہ    اندر      عالم    بقا\n"
                          "  ہست  فنا   از  گدا    و   بقا     از    خدا\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "عِنْدَنا یَنْفَدُ وَالْبَقَا عِنْدہ‘\n",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلْوَارِثُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "مال  مردہ    کا  میراث  کہلاتا  ہے\n"
                          "     زندہ  کی  وہ    وارثت  میں   آجاتا   ہے\n"
                          "   مرنے  والا  ہے  عالم  تو  مر جاتا  ہے\n"
                          " حق ہے زندہ  وہ   وارث  ہی  کہلاتا  ہے\n"
                          "    اس کو   وارث  سمجھتے  ہوئے  مانگ  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلرَّشِیْدُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "آفریدنِ  حق  بے    مثال    آمدہ\n"
                          "اَوَّلا ً       پیدا     کر دہ     ہمہ  خلق      را\n"
                          "بعد ازاں  صورتش    را      اعادہ    شدہ \n"
                          " گشت بدیع  او  سماوات   و   الارض    را\n"
                          "  پس  بداں   ایں  کمال ِ   خداواندِ    تو،\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: " تَعَدِّی",
                      style: TextStyle(
                        fontFamily: 'Al_Qalam',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "   تَعَدِّی   میں مرشِد    ہے  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DecoratedTextBlock(
              spans: [
                TextSpan(
                  text: "اَلصَّبُوْرُ \n",
                  style: TextStyle(
                    fontFamily: 'Al_Qalam',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "اے  صبورِ    دوعالم    تو  صبّار   ہے\n"
                          "تُو  تو   صبّار   با وصفِ    قہّار    ہے\n"
                          "دیکھتا   ہے  گنہ     پھر    بھی    ستّار   ہے\n"
                          "مجھ سے مجرم کا پھر بھی غفّار ہے\n"
                          "بخش دے   میرے  غفّار  و    صبّار  تو\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "اَللّٰہُ   اَللّٰہُ   اَللّٰہُ   اَللّٰہُ\n",
                      style: TextStyle(
                        fontFamily: 'Al_Majeed',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "━━━━❀❀❀━━━━\n",
                      style: TextStyle(
                        fontFamily: 'Alvi',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // The rest of the code as provided in the snippet appears to have structurally correct comma usage.
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
                            fontFamily: 'Saleem',
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
                            fontFamily: 'Saleem',
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
