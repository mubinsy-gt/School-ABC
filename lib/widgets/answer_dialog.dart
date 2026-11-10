import 'package:animations/animations.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class AnswerDialog extends StatefulWidget {
  final bool isCorrect;
final String correctAnswer;

// gambar jawaban benar (opsional)
final String? correctImage;

// apakah gambar ingin ditampilkan
final bool showImage;

final VoidCallback onContinue;

  const AnswerDialog({
  super.key,
  required this.isCorrect,
  required this.correctAnswer,
  this.correctImage,
  this.showImage = false,
  required this.onContinue,
});

  @override
  State<AnswerDialog> createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<AnswerDialog>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );

    if (widget.isCorrect) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Material(

      color: Colors.black54,

      child: Stack(

        alignment: Alignment.center,

        children: [

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality:
                  BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 25,
              gravity: 0.25,
            ),
          ),

          ScaleTransition(

            scale: _scaleAnimation,

            child: OpenContainer(

              transitionDuration:
                  const Duration(milliseconds: 400),

              closedElevation: 0,

              closedShape: RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(30),

              ),

              closedColor: Colors.transparent,

              openColor: Colors.transparent,

              tappable: false,

              openBuilder: (_, __) {

                return const SizedBox();

              },

              closedBuilder: (_, __) {

                return Container(

                  width: 340,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(30),

                    border: Border.all(

                      color: widget.isCorrect
                          ? Colors.green
                          : Colors.red,

                      width: 5,

                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black26,

                        blurRadius: 20,

                        offset: const Offset(0, 10),

                      )

                    ],

                  ),

                  child: Column(

                    mainAxisSize: MainAxisSize.min,

                    children: [
                      // ==========================
// ICON
// ==========================
Container(
  width: 110,
  height: 110,
  decoration: BoxDecoration(
    color: widget.isCorrect
        ? Colors.green.shade50
        : Colors.red.shade50,
    shape: BoxShape.circle,
  ),
  child: Icon(
    widget.isCorrect
        ? Icons.emoji_events
        : Icons.cancel,
    size: 65,
    color: widget.isCorrect
        ? Colors.orange
        : Colors.red,
  ),
),

const SizedBox(height: 20),

// ==========================
// JUDUL
// ==========================
Text(
  widget.isCorrect
      ? "🎉 BENAR! 🎉"
      : "❌ SALAH! ❌",
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: widget.isCorrect
        ? Colors.green
        : Colors.red,
  ),
),

const SizedBox(height: 20),

// ==========================
// BINTANG
// ==========================
if (widget.isCorrect)
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    3,
    (index) => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Icon(
        Icons.star,
        color: Colors.amber,
        size: 32,
      ),
    ),
  ),
),

if (widget.isCorrect)
const SizedBox(height: 20),

// ==========================
// EMOJI
// ==========================
Icon(
  widget.isCorrect
      ? Icons.sentiment_very_satisfied
      : Icons.sentiment_dissatisfied,
  color: widget.isCorrect
      ? Colors.orange
      : Colors.red,
  size: 55,
),

const SizedBox(height: 15),

// ==========================
// PESAN
// ==========================
Text(
  widget.isCorrect
      ? "Hebat!\nJawaban kamu benar."
      : "Yah...\nJawaban kamu masih salah.",
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.5,
  ),
),

const SizedBox(height: 20),

// ==========================
// JAWABAN BENAR
// ==========================
if (!widget.isCorrect)
Container(
  padding: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.orange.shade50,
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
      color: Colors.orange,
      width: 2,
    ),
  ),
  child: Column(
    children: [

      const Text(
        "Jawaban yang benar",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 10),

     if (widget.showImage && widget.correctImage != null)
  Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        widget.correctImage!,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      ),
    ),
  ),

Text(
  widget.correctAnswer,
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: Colors.deepOrange,
  ),
),
    ],
  ),
),

const SizedBox(height: 30),

// ==========================
// TOMBOL LANJUT
// ==========================
SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(

    icon: const Icon(Icons.arrow_forward),

    label: const Text(
      "LANJUT",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    style: ElevatedButton.styleFrom(

      backgroundColor: widget.isCorrect
          ? Colors.green
          : Colors.deepOrange,

      foregroundColor: Colors.white,

      elevation: 8,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    onPressed: () {

      Navigator.pop(context);

      widget.onContinue();

    },
  ),
),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}