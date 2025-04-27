

import 'dart:async';

import 'package:Mehvesujood/dashborad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class splash_screen_one extends StatefulWidget {
  @override
  _splash_screen_oneState createState() => _splash_screen_oneState();
}

class _splash_screen_oneState extends State<splash_screen_one> {
  void completed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  onPlayAudio() async {
    assetsAudioPlayer.open(
      Audio('assets/ALLAHU.mp3'),
      autoStart: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetsAudioPlayer.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onPlayAudio();
    assetsAudioPlayer.play();
      Timer(Duration(seconds: 10), completed);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Splashscreen2.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                /* add child content here */
              )),
        ],
      ),
    );
  }
}