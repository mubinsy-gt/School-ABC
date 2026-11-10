import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_abc/widgets/abjad_tile.dart';
import 'package:school_abc/widgets/custom_scroll.dart';
import 'package:audioplayers/audioplayers.dart'; // ✅ Tambah ini
import '../audio_manager.dart';
import '../models/abjad.dart';
import 'abjad_screen.dart';

class ListAbjadScreen extends StatefulWidget {
  const ListAbjadScreen({super.key});

  @override
  State<ListAbjadScreen> createState() => _ListAbjadScreenState();
}

class _ListAbjadScreenState extends State<ListAbjadScreen> {
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
    AssetSource('backsound/backsound.mp3'),
  );
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
  await backsoundPlayer.stop();

  if (!mounted) return;

  Navigator.pushNamedAndRemoveUntil(
      context, '/main', (route) => false);
},
        ),
      ),
      backgroundColor: const Color(0xff7292CF),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: Text(
              'Pilih Abjad'.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                letterSpacing: 10,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: ScrollConfiguration(
                behavior: CustomScroll(),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: .95),
                    itemCount: abjadList.length,
                    itemBuilder: (context, index) {
                      final Abjad abjad = abjadList[index];
                      return AbjadTile(
                        abjad: abjad.abjad,
                        onPressed: () async {
  await backsoundPlayer.stop();

  if (!mounted) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return AbjadScreen(
          abjad: abjad,
        );
      },
    ),
  );
},
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
