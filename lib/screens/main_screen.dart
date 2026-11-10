import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // ✅ Tambahkan ini
import '../widgets/button_menu.dart';
import '../audio_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AudioPlayer backsoundPlayer = AudioPlayer();

  @override
void initState() {
  super.initState();

  AudioManager.instance.register(backsoundPlayer);

  playBacksound();
}


  Future<void> playBacksound() async {
  await backsoundPlayer.stop();

  await backsoundPlayer.setReleaseMode(ReleaseMode.loop);
  await backsoundPlayer.setVolume(1.0);

   AudioManager.instance.setActivePlayer(backsoundPlayer);

  await backsoundPlayer.play(
    AssetSource('backsound/menuutama.mp3'),
  );
}

  void stopBacksound() {
    backsoundPlayer.stop();
  }

@override
void dispose() {
  AudioManager.instance.unregister(backsoundPlayer);

  backsoundPlayer.stop();
  backsoundPlayer.dispose();

  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7292CF),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/bg menu.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/icons/bg bawah.png',
              width: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: RotatedBox(
              quarterTurns: 2,
              child: Image.asset(
                'assets/icons/bg bawah.png',
                width: double.infinity,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.7, end: 1),
  duration: const Duration(milliseconds: 900),
  curve: Curves.elasticOut,
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
  child: Image.asset(
    'assets/icons/Logo.png',
    height: 130,
  ),
),
const SizedBox(height: 15),

const Text(
  "Belajar Huruf Jadi Lebih Menyenangkan",
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    shadows: [
      Shadow(
        blurRadius: 8,
        color: Colors.black26,
      ),
    ],
  ),
),
                const SizedBox(height:55),
               ButtonMenu(
  title: "Menu Abjad",
  icon: Icons.auto_stories_rounded,
  onPressed: () {
  Navigator.pushNamed(context, '/list-abjad');
},
),
                ButtonMenu(
  title: "Quiz",
  icon: Icons.quiz_rounded,
  onPressed: () {
  Navigator.pushNamed(context, '/quiz');
},
),
                ButtonMenu(
  title: "Tentang",
  icon: Icons.info_outline_rounded,
  onPressed: () {
  Navigator.pushNamed(context, '/about');
},
),
                ButtonMenu(
  title: "Keluar",
  icon: Icons.logout_rounded,
  onPressed: () {
    stopBacksound();
    exit(0);
  },
),
const SizedBox(height:25),

const Text(
  "Versi 1.0.0",
  style: TextStyle(
    color: Colors.white70,
    fontSize: 15,
  ),
),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
