import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_abc/widgets/button_navigation.dart';
import '../audio_manager.dart';
import '../models/abjad.dart';

class AbjadScreen extends StatefulWidget {
  final Abjad abjad;
  const AbjadScreen({super.key, required this.abjad});

  @override
  State<AbjadScreen> createState() => _AbjadScreenState();
}

class _AbjadScreenState extends State<AbjadScreen> {
  // === AUDIO UTAMA (A untuk Angsa) ===
  bool isPlaying = false;
  bool audioPlayed = false;
  late Uint8List audiobytes;
  AudioPlayer player = AudioPlayer();

  // === BACKSOUND ===
  double normalVolume = 1.0; // volume normal backsound
  double lowVolume = 0.2;    // volume kecil saat audio huruf diputar

  @override
void initState() {
  super.initState();


  Future.delayed(Duration.zero, () async {
    ByteData bytes = await rootBundle.load(widget.abjad.audioUrl);

    audiobytes = bytes.buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );

    if (mounted) {
      setState(() {});
    }
  });

  playBacksound();
}


  Future<void> playBacksound() async {
  await AudioManager.instance.playAbjadBacksound();
}

  Future<void> reduceBacksound() async {
  await AudioManager.instance.abjadPlayer.setVolume(lowVolume);
}

Future<void> restoreBacksound() async {
  await AudioManager.instance.abjadPlayer.setVolume(normalVolume);
}

  Future<void> play() async {
  if (!isPlaying && !audioPlayed) {
    try {
      await reduceBacksound();

      await player.setAudioContext(
        AudioContext(
          android: AudioContextAndroid(
            audioFocus: AndroidAudioFocus.none,
          ),
        ),
      );

      await player.play(
        BytesSource(audiobytes),
      );

      if (mounted) {
        setState(() {
          isPlaying = true;
          audioPlayed = true;
        });
      }

      player.onPlayerComplete.first.then((event) async {
        await restoreBacksound();

        if (mounted) {
          setState(() {
            isPlaying = false;
            audioPlayed = false;
          });
        }
      });
    } catch (e) {
      print("ERROR AUDIO HURUF: $e");

      await restoreBacksound();

      if (mounted) {
        setState(() {
          isPlaying = false;
          audioPlayed = false;
        });
      }
    }
  }
}
@override
void dispose() {
  player.dispose();
  super.dispose();
}

int _getIndex(String huruf) {
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return alphabet.indexOf(huruf[0].toUpperCase()) + 1;
}

  @override
  Widget build(BuildContext context) {
    // =====================
    // SEMUA TAMPILAN TETAP
    // =====================
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff7292CF),
                    Color(0xff2855AE),
                  ]),
                ),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/icons/bg atas.png',
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: deviceWidth <= 393 ? 60 : 120,
                      bottom: deviceWidth < 393 ? 40 : 120),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 12,
                    ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white24,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.15),
                        blurRadius: 12,
                        offset: const Offset(0,5),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.abjad.abjad,
                    style: GoogleFonts.poppins(
                    fontSize: deviceWidth <= 360 ? 38 : 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 6,
                  ),
                  ),
                ),
                const SizedBox(height: 8),

Text(
  "${_getIndex(widget.abjad.abjad)}/26",
  style: GoogleFonts.poppins(
    color: Colors.white70,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),

const SizedBox(height: 8),

SizedBox(
  width: 180,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: LinearProgressIndicator(
      value: _getIndex(widget.abjad.abjad) / 26,
      minHeight: 8,
      backgroundColor: Colors.white24,
      valueColor: const AlwaysStoppedAnimation(
        Colors.amber,
      ),
    ),
  ),
),

const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, left: 16),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                      child: Column(
                      children: [
                        Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      widget.abjad.imageUrl,
      height: 180,
      fit: BoxFit.cover,
    ),
  ),
),
                        const SizedBox(height: 20),
                        Text(
                          widget.abjad.animalName.toUpperCase(),
                          style: GoogleFonts.schoolbell(fontSize: 30),
                        ),
                        const SizedBox(height: 17),
                        Container(
  margin: const EdgeInsets.symmetric(horizontal: 15),
  padding: const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 16,
  ),
  decoration: BoxDecoration(
    color: const Color(0xffF3F8FF),
    borderRadius: BorderRadius.circular(22),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(.10),
        blurRadius: 15,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    children: [

      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.volume_up_rounded,
          color: Colors.blue,
          size: 28,
        ),
      ),

      const SizedBox(width: 15),

     Expanded(
  child: Center(
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isPlaying
          ? Row(
              key: const ValueKey(1),
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => TweenAnimationBuilder<double>(
                  tween: Tween(begin: 8, end: 26),
                  duration: Duration(
                    milliseconds: 250 + (index * 100),
                  ),
                  curve: Curves.easeInOut,
                  onEnd: () {
                    if (mounted && isPlaying) {
                      setState(() {});
                    }
                  },
                  builder: (context, value, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 5,
                      height: value,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
            )
          : const Icon(
              Icons.multitrack_audio,
              key: ValueKey(2),
              color: Colors.blue,
              size: 40,
            ),
    ),
  ),
),

      InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          play();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xffFFD54F),
                Color(0xffFFB300),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(.35),
                blurRadius: 15,
              )
            ],
          ),
          child: Icon(
            isPlaying
                ? Icons.pause
                : Icons.play_arrow_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    ],
  ),
),
AnimatedOpacity(
  duration: const Duration(milliseconds: 300),
  opacity: isPlaying ? 1 : 0,
  child: const Padding(
    padding: EdgeInsets.only(top: 12),
    child: Icon(
      Icons.graphic_eq_rounded,
      color: Colors.blue,
      size: 30,
    ),
  ),
),
                        const Spacer(),
                        const SizedBox(height: 15),
                      ],
                    ),
                    ),
                  ),
                            ],
            ),
          ),
         Align(
  alignment: Alignment.bottomCenter,
  child: Stack(
    alignment: Alignment.bottomCenter,
    children: [

      Image.asset(
        'assets/icons/bg bawah.png',
      ),

      Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ButtonNavigation(
              backgroundColor: const Color(0xffD67676),
              iconImage: Image.asset(
                'assets/icons/Vic black close.png',
              ),
              borderRadius: 15,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/list-abjad',
                    (route) => true);
              },
            ),

            ButtonNavigation(
              backgroundColor: const Color(0xff06BFAD),
              iconImage: Image.asset(
                'assets/icons/ic black back-1.png',
              ),
              borderRadius: 15,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    widget.abjad.previousRoute,
                    (route) => true);
              },
            ),

            ButtonNavigation(
              backgroundColor: const Color(0xff06BFAD),
              iconImage: Image.asset(
                'assets/icons/ic black back.png',
              ),
              borderRadius: 15,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    widget.abjad.nextRoute,
                    (route) => true);
              },
            ),

          ],
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
