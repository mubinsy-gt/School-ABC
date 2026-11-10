import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:page_transition/page_transition.dart';
import 'main_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
  with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
@override
void initState() {
  super.initState();

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  _scaleAnimation = Tween<double>(
    begin: 0.95,
    end: 1.05,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );
}

  @override
void dispose() {
  _controller.dispose();
  _audioPlayer.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🟦 Background (sama dengan SplashScreen)
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

          // 🟨 Logo (posisi & ukuran sama dengan SplashScreen)
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
        Align(
  alignment: Alignment.center,
  child: ScaleTransition(
    scale: _scaleAnimation,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: const MainScreen(),
              type: PageTransitionType.fade,
            ),
          );
        },
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xff4F7CF7),
                Color(0xff3559B8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.45),
                blurRadius: 30,
                spreadRadius: 8,
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 75,
              ),

              SizedBox(height: 8),

              Text(
                "MULAI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),
          // ▶️ Tombol Play di tengah
  
        ],
      ),
    );
  }
}
