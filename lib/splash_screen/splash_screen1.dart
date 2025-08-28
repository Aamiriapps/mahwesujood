import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Mehvesujood/dashborad.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({Key? key}) : super(key: key);

  @override
  _SplashScreenOneState createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
    Timer(const Duration(seconds: 10), _navigateToDashboard);
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.setAsset('assets/ALLAHU.mp3');
      _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Image.asset(
            "assets/Splashscreen2.png",
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.8, // scale image
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
      ),
    );
  }
}
