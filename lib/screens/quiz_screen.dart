import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_abc/widgets/button_navigation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:school_abc/screens/quiz_result.dart';
import 'package:school_abc/widgets/answer_dialog.dart';

// ============================
// Data Abjad
// ============================
final List<Map<String, String>> abjadData = [
  {"huruf": "A", "gambar": "assets/images/a.png", "kata": "ANGSA", "audio": "assets/quiz_audio/A.mp3"},
  {"huruf": "B", "gambar": "assets/images/b.png", "kata": "BADAK", "audio": "assets/quiz_audio/B.mp3"},
  {"huruf": "C", "gambar": "assets/images/c.png", "kata": "CICAK", "audio": "assets/quiz_audio/C.mp3"},
  {"huruf": "D", "gambar": "assets/images/d.png", "kata": "DOMBA", "audio": "assets/quiz_audio/D.mp3"},
  {"huruf": "E", "gambar": "assets/images/e.png", "kata": "ELANG", "audio": "assets/quiz_audio/E.mp3"},
  {"huruf": "F", "gambar": "assets/images/f.png", "kata": "FLAMINGO", "audio": "assets/quiz_audio/F.mp3"},
  {"huruf": "G", "gambar": "assets/images/g.png", "kata": "GAJAH", "audio": "assets/quiz_audio/G.mp3"},
  {"huruf": "H", "gambar": "assets/images/h.png", "kata": "HARIMAU", "audio": "assets/quiz_audio/H.mp3"},
  {"huruf": "I", "gambar": "assets/images/i.png", "kata": "IGUANA", "audio": "assets/quiz_audio/I.mp3"},
  {"huruf": "J", "gambar": "assets/images/j.png", "kata": "JERAPAH", "audio": "assets/quiz_audio/J.mp3"},
  {"huruf": "K", "gambar": "assets/images/k.png", "kata": "KUCING", "audio": "assets/quiz_audio/K.mp3"},
  {"huruf": "L", "gambar": "assets/images/l.png", "kata": "LANDAK", "audio": "assets/quiz_audio/L.mp3"},
  {"huruf": "M", "gambar": "assets/images/m.png", "kata": "MUSANG", "audio": "assets/quiz_audio/M.mp3"},
  {"huruf": "N", "gambar": "assets/images/n.png", "kata": "NYAMUK", "audio": "assets/quiz_audio/N.mp3"},
  {"huruf": "O", "gambar": "assets/images/o.png", "kata": "ORANGUTAN", "audio": "assets/quiz_audio/O.mp3"},
  {"huruf": "P", "gambar": "assets/images/p.png", "kata": "PINGUIN", "audio": "assets/quiz_audio/P.mp3"},
  {"huruf": "Q", "gambar": "assets/images/q.png", "kata": "QUOLL", "audio": "assets/quiz_audio/Q.mp3"},
  {"huruf": "R", "gambar": "assets/images/r.png", "kata": "RUSA", "audio": "assets/quiz_audio/R.mp3"},
  {"huruf": "S", "gambar": "assets/images/s.png", "kata": "SINGA", "audio": "assets/quiz_audio/S.mp3"},
  {"huruf": "T", "gambar": "assets/images/t.png", "kata": "TUPAI", "audio": "assets/quiz_audio/T.mp3"},
  {"huruf": "U", "gambar": "assets/images/u.png", "kata": "ULAR", "audio": "assets/quiz_audio/U.mp3"},
  {"huruf": "V", "gambar": "assets/images/v.png", "kata": "VICUNA", "audio": "assets/quiz_audio/V.mp3"},
  {"huruf": "W", "gambar": "assets/images/w.png", "kata": "WALRUS", "audio": "assets/quiz_audio/W.mp3"},
  {"huruf": "X", "gambar": "assets/images/x.png", "kata": "XERUS", "audio": "assets/quiz_audio/X.mp3"},
  {"huruf": "Y", "gambar": "assets/images/y.png", "kata": "YAK", "audio": "assets/quiz_audio/Y.mp3"},
  {"huruf": "Z", "gambar": "assets/images/z.png", "kata": "ZEBRA", "audio": "assets/quiz_audio/Z.mp3"},
];


// ============================
// Linear Congruential Method (LCM)
// ============================
class LCMRandom {
  int _seed;
  final int _a = 1664525;     // multiplier
  final int _c = 1013904223;  // increment
  final int _m = 4294967296;  // modulus (2^32)

  LCMRandom(this._seed);

  int nextInt(int max) {
    _seed = (_a * _seed + _c) % _m;
    return _seed % max;
  }
}

// ============================
// Mode Quiz
// ============================
// ============================
// Mode Quiz
// ============================
enum QuizMode {
  tebakHurufDariGambar,
  tebakGambarDariHuruf,
  fillBlank,
  tebakAudio,
}

class QuizQuestion {
  final QuizMode mode;
  final Map<String, String> data;

  QuizQuestion({
    required this.mode,
    required this.data,
  });
}

// ============================
// Quiz Screen
// ============================
class QuizScreen extends StatefulWidget {
  final int level;

  const QuizScreen({
    super.key,
    required this.level,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late LCMRandom _rand;
  late List<QuizQuestion> _quizSet;
  int _currentIndex = 0;
  int _score = 0;

  // 🎵 BACKSOUND PLAYER
  final AudioPlayer _bgPlayer = AudioPlayer();

  // 🔊 PLAYER UNTUK SUARA BENAR / SALAH
final AudioPlayer _effectPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _rand = LCMRandom(DateTime.now().millisecondsSinceEpoch);
    _quizSet = _generateQuizSet();
    print("Jumlah soal: ${_quizSet.length}");
    _playBackgroundMusic(); // 🔥 mulai backsound
  }

  // 🔊 Fungsi untuk mulai backsound
 Future<void> _playBackgroundMusic() async {
  await _bgPlayer.setReleaseMode(ReleaseMode.loop);
  await _bgPlayer.setVolume(0.3);
  await _bgPlayer.play(
    AssetSource('backsound/quizz.mp3'),
  );
}

  Future<void> _playCorrectSound() async {
  await _effectPlayer.stop();
  await _effectPlayer.play(
    AssetSource('backsound/benar.mp3'),
  );
}

Future<void> _playWrongSound() async {
  await _effectPlayer.stop();
  await _effectPlayer.play(
    AssetSource('backsound/salah.mp3'),
  );
}

  // 🛑 Hentikan musik saat keluar
  @override
void dispose() {
  _bgPlayer.stop();
  _bgPlayer.dispose();

  _effectPlayer.dispose();

  super.dispose();
}


List<QuizQuestion> _generateQuizSet() {
  final List<Map<String, String>> levelData;

  switch (widget.level) {
    case 1:
      levelData = abjadData.sublist(0, 7);
      break;
    case 2:
      levelData = abjadData.sublist(7, 14);
      break;
    case 3:
      levelData = abjadData.sublist(14, 20);
      break;
    case 4:
      levelData = abjadData.sublist(20, 26);
      break;
    default:
      levelData = abjadData;
  }

  final List<QuizQuestion> quizSet = [];

for (var data in levelData) {
  for (var mode in QuizMode.values) {
    quizSet.add(
      QuizQuestion(
        mode: mode,
        data: data,
      ),
    );
  }
}

// Acak urutan soal menggunakan LCM
for (int i = quizSet.length - 1; i > 0; i--) {
  int j = _rand.nextInt(i + 1);

  final temp = quizSet[i];
  quizSet[i] = quizSet[j];
  quizSet[j] = temp;
}

return quizSet.take(5).toList();
}

Future<void> _answer(
  bool correct,
  String correctAnswer, {
  String? correctImage,
  bool showImage = false,
}) async {

  if (correct) {
    _score++;
    await _playCorrectSound();
  } else {
    await _playWrongSound();
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AnswerDialog(
  isCorrect: correct,
  correctAnswer: correctAnswer,
  correctImage: correctImage,
  showImage: showImage,

  onContinue: () async {
    
    await _playBackgroundMusic();

        if (_currentIndex < _quizSet.length - 1) {

          setState(() {
            _currentIndex++;
          });

        } else {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => QuizResultScreen(
                score: _score,
                totalQuestion: _quizSet.length,
                level: widget.level,
              ),
            ),
          );

        }

      },
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    final soal = _quizSet[_currentIndex];
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradasi
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff7292CF), Color(0xff2855AE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Dekorasi atas
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/icons/bg atas.png'),
          ),
          // Dekorasi bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/icons/bg bawah.png'),
          ),

          // Konten utama
          SafeArea(
            child: Column(
              children: [
                // Judul Quiz
                Container(
                  margin: EdgeInsets.only(
                      top: deviceWidth <= 393 ? 40 : 80,
                      bottom: deviceWidth < 393 ? 20 : 60),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0x10000000),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "QUIZ ${_currentIndex + 1}/${_quizSet.length}",
                    style: GoogleFonts.poppins(
                      fontSize: deviceWidth <= 360 ? 20 : 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Kotak soal
              // Kotak soal full bawah
Expanded(
  child: Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: SingleChildScrollView(
      child: _buildQuestion(soal),
    ),
  ),
),




                const SizedBox(height: 20),

                // Tombol navigasi bawah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonNavigation(
                      backgroundColor: const Color(0xffD67676),
                      iconImage:
                          Image.asset('assets/icons/Vic black close.png'),
                      borderRadius: 15,
                      onPressed: () {
  Navigator.pop(context);
},
                    ),
                    ButtonNavigation(
                      backgroundColor: const Color(0xff06BFAD),
                      iconImage:
                          Image.asset('assets/icons/ic black back-1.png'),
                      borderRadius: 15,
                      onPressed: () {
                        if (_currentIndex > 0) {
                          setState(() => _currentIndex--);
                        }
                      },
                    ),
                    ButtonNavigation(
                      backgroundColor: const Color(0xff06BFAD),
                      iconImage:
                          Image.asset('assets/icons/ic black back.png'),
                      borderRadius: 15,
                      onPressed: () {
                        if (_currentIndex < _quizSet.length - 1) {
                          setState(() => _currentIndex++);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================
  // Variasi Soal
  // =============================
Widget _buildQuestion(QuizQuestion q) {
  switch (q.mode) {
    case QuizMode.tebakHurufDariGambar:
      return _tebakHurufDariGambar(q);

    case QuizMode.tebakGambarDariHuruf:
      return _tebakGambarDariHuruf(q);

    case QuizMode.fillBlank:
      return _fillBlank(q);

    case QuizMode.tebakAudio:
      return _tebakAudio(q);
  }
}

//==================================================
// Tebak Huruf dari Gambar
//==================================================
Widget _tebakHurufDariGambar(QuizQuestion q) {
  final correct = q.data["huruf"]!;
  final img = q.data["gambar"]!;

  final options = <String>{correct};

  while (options.length < 4) {
    options.add(
      abjadData[_rand.nextInt(abjadData.length)]["huruf"]!,
    );
  }

  final opsiList = options.toList();

  // Acak menggunakan LCM
  for (int i = opsiList.length - 1; i > 0; i--) {
    int j = _rand.nextInt(i + 1);

    final temp = opsiList[i];
    opsiList[i] = opsiList[j];
    opsiList[j] = temp;
  }

  return SingleChildScrollView(
    child: Column(
      children: [

        const SizedBox(height: 15),

        const Text(
          "Huruf apa untuk gambar ini?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),

        const SizedBox(height: 20),

        //==============================
        // CARD GAMBAR
        //==============================
        Container(
          width: 250,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Image.asset(
            img,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 30),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: opsiList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) {
            final o = opsiList[index];

            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),

                onTap: () {
                  _answer(
                    o == correct,
                    correct,
                  );
                },

                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff64B5F6),
                        Color(0xff42A5F5),
                      ],
                    ),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),

                  child: Center(
                    child: Text(
                      o,
                      style: const TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

//==================================================
// Tebak Gambar dari Huruf
//==================================================
Widget _tebakGambarDariHuruf(QuizQuestion q) {
  final huruf = q.data["huruf"]!;
  final correct = q.data;

  final options = <Map<String, String>>{correct};

  while (options.length < 4) {
    options.add(
      abjadData[_rand.nextInt(abjadData.length)],
    );
  }

  final opsiList = options.toList();

  // Acak menggunakan LCM
  for (int i = opsiList.length - 1; i > 0; i--) {
    int j = _rand.nextInt(i + 1);

    final temp = opsiList[i];
    opsiList[i] = opsiList[j];
    opsiList[j] = temp;
  }

  return SingleChildScrollView(
    child: Column(
      children: [

        const SizedBox(height: 15),

        Text(
          "Pilih gambar hewan\nberawalan huruf $huruf",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 25),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: opsiList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final o = opsiList[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  _answer(
                    o["huruf"] == huruf,
                    correct["kata"]!,
                    correctImage: correct["gambar"],
                    showImage: true,
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.blue.shade100,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0,4),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: o["gambar"]!,
                            child: Image.asset(
                              o["gambar"]!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              o["huruf"]!,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

//==================================================
// Fill In The Blank
//==================================================
Widget _fillBlank(QuizQuestion q) {
  final huruf = q.data["huruf"]!;
  final kata = q.data["kata"]!;
  final soal = kata.replaceFirst(huruf, "_");

  final options = <String>{huruf};

  while (options.length < 4) {
    options.add(
      abjadData[_rand.nextInt(abjadData.length)]["huruf"]!,
    );
  }

  final opsiList = options.toList();

  // Acak menggunakan LCM
  for (int i = opsiList.length - 1; i > 0; i--) {
    int j = _rand.nextInt(i + 1);

    final temp = opsiList[i];
    opsiList[i] = opsiList[j];
    opsiList[j] = temp;
  }

  return SingleChildScrollView(
    child: Column(
      children: [

        const SizedBox(height: 15),

        const Text(
          "Lengkapi huruf yang hilang",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),

        const SizedBox(height: 25),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.orange,
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Column(
            children: [

              const Icon(
                Icons.edit,
                color: Colors.orange,
                size: 45,
              ),

              const SizedBox(height: 15),

              Text(
                soal,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: opsiList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) {
            final o = opsiList[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  _answer(
                    o == huruf,
                    huruf,
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFFB74D),
                        Color(0xffFB8C00),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0,4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      o,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

//==================================================
// Tebak Audio
//==================================================
Widget _tebakAudio(QuizQuestion q) {
  final correct = q.data["huruf"]!;
  final audio = q.data["audio"]!.replaceFirst("assets/", "");

  final options = <String>{correct};

  while (options.length < 4) {
    options.add(
      abjadData[_rand.nextInt(abjadData.length)]["huruf"]!,
    );
  }

  final opsiList = options.toList();

  // Acak menggunakan LCM
  for (int i = opsiList.length - 1; i > 0; i--) {
    int j = _rand.nextInt(i + 1);

    final temp = opsiList[i];
    opsiList[i] = opsiList[j];
    opsiList[j] = temp;
  }

  return SingleChildScrollView(
    child: Column(
      children: [

        const SizedBox(height: 15),

        const Text(
          "Dengarkan suara\nlalu pilih huruf yang benar",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),

        const SizedBox(height: 25),

        //==========================
        // CARD AUDIO
        //==========================
        Container(
          width: 260,
          padding: const EdgeInsets.symmetric(
            vertical: 25,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0,5),
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 60,
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    await _effectPlayer.stop();
                    await _effectPlayer.play(
                      AssetSource(audio),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Putar Audio",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Tekan ikon speaker",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: opsiList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context,index){
            final o = opsiList[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  _answer(
                    o == correct,
                    correct,
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff4FC3F7),
                        Color(0xff039BE5),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0,4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      o,
                      style: const TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
  // Puzzle
}
