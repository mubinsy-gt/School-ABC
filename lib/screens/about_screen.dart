import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/button_menu.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                    image: AssetImage('assets/icons/bg menu.png'))),
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
  children: [

    Image.asset(
      'assets/icons/Logo.png',
      height: 120,
    ),

    const SizedBox(height: 15),


    const SizedBox(height: 5),

    Text(
      "Belajar Huruf Jadi Lebih Menyenangkan",
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),

    const SizedBox(height: 30),

    Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: const [
                  Icon(Icons.menu_book,
                      color: Colors.blue, size: 30),
                  SizedBox(width: 10),
                  Text(
                    "Tentang Aplikasi",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Text(
                "School ABC merupakan aplikasi pembelajaran interaktif yang dirancang untuk membantu anak-anak mengenal huruf alfabet Bahasa Indonesia melalui ilustrasi hewan, audio pelafalan, serta permainan edukatif yang menarik.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  height: 1.8,
                ),
              ),

              const SizedBox(height: 25),

              const Divider(),

              const SizedBox(height: 10),

              Row(
                children: const [
                  Icon(Icons.star,
                      color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Belajar huruf A-Z dengan ilustrasi hewan.",
                    ),
                  )
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Icon(Icons.volume_up,
                      color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Audio pelafalan setiap huruf dan kata.",
                    ),
                  )
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Icon(Icons.quiz,
                      color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Quiz interaktif dengan beberapa jenis permainan.",
                    ),
                  )
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Icon(Icons.shuffle,
                      color: Colors.deepPurple),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Pengacakan soal menggunakan metode Linear Congruential Method (LCM).",
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    const Text(
                      "Informasi Aplikasi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Versi"),
                        Text("1.0.0"),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Platform"),
                        Text("Android"),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Metode"),
                        Text("LCM"),
                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ),

    const SizedBox(height: 20),

    ButtonMenu(
  title: "Kembali",
  icon: Icons.arrow_back_rounded,
  onPressed: () {
    Navigator.pop(context);
  },
),

  ],
)
          )
        ],
      ),
    );
  }
}
