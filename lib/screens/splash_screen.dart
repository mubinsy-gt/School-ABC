import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:page_transition/page_transition.dart';
import 'package:school_abc/screens/play_screen.dart'; // ganti ke PlayScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _playSplashSound();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageTransition(
          child: const PlayScreen(), // <-- ganti ke PlayScreen
          type: PageTransitionType.size,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  Future<void> _playSplashSound() async {
    await _audioPlayer.play(
      AssetSource('backsound/splash.mp3'),
      volume: 1.0,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/vector.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 200),
              child: Image.asset(
                'assets/icons/Logo.png',
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
