import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_screen.dart';

class QuizLevelScreen extends StatefulWidget {
  const QuizLevelScreen({super.key});

  @override
  State<QuizLevelScreen> createState() => _QuizLevelScreenState();
}

class _QuizLevelScreenState extends State<QuizLevelScreen> {
  final AudioPlayer _levelPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playLevelMusic();
  }

  Future<void> _playLevelMusic() async {
  await _levelPlayer.stop();

  await _levelPlayer.setReleaseMode(ReleaseMode.loop);
  await _levelPlayer.setVolume(1.0);

  await _levelPlayer.play(
    AssetSource('backsound/level.mp3'),
  );
}

  @override
  void dispose() {
    _levelPlayer.stop();
    _levelPlayer.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
  title: const Text(
    "Pilih Level Quiz",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true,
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme: const IconThemeData(color: Colors.white),
),
extendBodyBehindAppBar: true,

    body: Stack(
  children: [

    // Background utama
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/icons/bg menu.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),

    // Background atas
    Align(
      alignment: Alignment.topCenter,
      child: Image.asset(
        "assets/icons/bg atas.png",
        fit: BoxFit.cover,
      ),
    ),

    // Isi halaman
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
      child: ListView(
        children: [

          _levelCard(
            context,
            level: 1,
            title: "Level 1",
            subtitle: "Huruf A - G\n28 Soal",
            color: Colors.green,
          ),

          const SizedBox(height: 15),

          _levelCard(
            context,
            level: 2,
            title: "Level 2",
            subtitle: "Huruf H - N\n28 Soal",
            color: Colors.orange,
          ),

          const SizedBox(height: 15),

          _levelCard(
            context,
            level: 3,
            title: "Level 3",
            subtitle: "Huruf O - T\n24 Soal",
            color: Colors.deepPurple,
          ),

          const SizedBox(height: 15),

          _levelCard(
            context,
            level: 4,
            title: "Level 4",
            subtitle: "Huruf U - Z\n24 Soal",
            color: Colors.red,
          ),

          const SizedBox(height: 100),

        ],
      ),
    ),

    // Background bawah
    Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        "assets/icons/bg bawah.png",
        fit: BoxFit.cover,
      ),
    ),
  ],
),
    );
  }

  Widget _levelCard(
    BuildContext context, {
    required int level,
    required String title,
    required String subtitle,
    required Color color,
  }) {
   return Card(
  color: Colors.white,
  elevation: 12,
  shadowColor: Colors.black26,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(22),
    side: BorderSide(
      color: Colors.blue.shade100,
      width: 1.2,
    ),
  ),
  clipBehavior: Clip.antiAlias,
      child: ListTile(
  splashColor: Colors.blue.withOpacity(.20),
  hoverColor: Colors.grey.shade200,
  tileColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            "$level",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => QuizScreen(level: level),
    ),
  );

  // Putar kembali backsound level setelah kembali
  _playLevelMusic();
},
      ),
    );
  }
}