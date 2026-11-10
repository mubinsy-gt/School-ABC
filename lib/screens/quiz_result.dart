import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'main_screen.dart';
import 'quiz_level.dart';
import 'quiz_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestion;
  final int level;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestion,
    required this.level,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final AudioPlayer _resultPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();

    _playResultSound();
  }

  Future<void> _playResultSound() async {
  await _resultPlayer.setReleaseMode(ReleaseMode.loop);

  await _resultPlayer.play(
    AssetSource('backsound/result.mp3'),
  );
}

  @override
  void dispose() {
    _controller.dispose();
    _resultPlayer.dispose();
    super.dispose();
  }

  double get percentage =>
      (widget.score / widget.totalQuestion) * 100;

  int get star {

    if (percentage >= 90) {
      return 3;
    }

    if (percentage >= 70) {
      return 2;
    }

    return 1;
  }

  String get message {

    if (percentage >= 90) {
      return "Hebat! Kamu menguasai materi pada level ini.";
    }

    if (percentage >= 70) {
      return "Bagus! Terus semangat belajar ya.";
    }

    return "Jangan menyerah. Yuk coba lagi supaya lebih hebat!";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xff42A5F5),

              Color(0xff7E57C2),

            ],

          ),

        ),

        child: SafeArea(

          child: ScaleTransition(

            scale: _scaleAnimation,

            child: Center(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: Card(

                  elevation: 18,

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(30),

                  ),

                  child: Padding(

                    padding: const EdgeInsets.all(25),

                    child: Column(

                      mainAxisSize: MainAxisSize.min,

                      children: [
                        // ==========================
// Trophy
// ==========================
Container(
  width: 120,
  height: 120,
  decoration: BoxDecoration(
    color: Colors.amber.shade100,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.amber.withOpacity(0.5),
        blurRadius: 20,
        spreadRadius: 3,
      ),
    ],
  ),
  child: const Icon(
    Icons.emoji_events,
    color: Colors.orange,
    size: 70,
  ),
),

const SizedBox(height: 20),

Text(
  "LEVEL ${widget.level} SELESAI",
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple,
  ),
),

const SizedBox(height: 15),

// ==========================
// Bintang
// ==========================
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    3,
    (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        index < star ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 38,
      ),
    ),
  ),
),

const SizedBox(height: 25),

// ==========================
// Circle Score
// ==========================
Container(
  width: 170,
  height: 170,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.blue.shade50,
    border: Border.all(
      color: Colors.blue,
      width: 6,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(.2),
        blurRadius: 15,
      ),
    ],
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      const Text(
        "SCORE",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),

      const SizedBox(height: 8),

      Text(
        "${widget.score}/${widget.totalQuestion}",
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 8),

      Text(
        "${percentage.toStringAsFixed(0)}%",
        style: const TextStyle(
          fontSize: 22,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 25),

// ==========================
// Pesan
// ==========================
Text(
  message,
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontSize: 18,
    height: 1.5,
    fontWeight: FontWeight.w500,
  ),
),

const SizedBox(height: 35),
// ==========================
// Tombol Main Lagi
// ==========================
SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.refresh, color: Colors.white),
    label: const Text(
      "MAIN LAGI",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: QuizScreen(level: widget.level),
          type: PageTransitionType.rightToLeft,
        ),
      );
    },
  ),
),

const SizedBox(height: 15),

// ==========================
// Tombol Pilih Level
// ==========================
SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.extension, color: Colors.white),
    label: const Text(
      "PILIH LEVEL",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const QuizLevelScreen(),
          type: PageTransitionType.leftToRight,
        ),
      );
    },
  ),
),

const SizedBox(height: 15),

// ==========================
// Tombol Menu Utama
// ==========================
SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.home, color: Colors.white),
    label: const Text(
      "MENU UTAMA",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    onPressed: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const MainScreen(),
    ),
    (route) => false,
  );
},
  ),
),

const SizedBox(height: 15),

Text(
  "Terima kasih sudah belajar 😊",
  style: TextStyle(
    color: Colors.grey.shade600,
    fontWeight: FontWeight.w600,
    fontSize: 15,
  ),
),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}