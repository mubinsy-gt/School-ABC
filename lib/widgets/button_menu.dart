import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonMenu extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<ButtonMenu> createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {

  double scale = 1;

  @override
  Widget build(BuildContext context) {

    return AnimatedScale(

      duration: const Duration(milliseconds: 120),

      scale: scale,

      child: Container(

        margin: const EdgeInsets.only(bottom: 15),

        child: Material(

          color: Colors.transparent,

          child: InkWell(

            borderRadius: BorderRadius.circular(18),

            onTapDown: (_) {
              setState(() => scale = .97);
            },

            onTapCancel: () {
              setState(() => scale = 1);
            },

            onTapUp: (_) {

              setState(() => scale = 1);

              widget.onPressed();

            },

            child: Ink(

              height: 58,

              decoration: BoxDecoration(

               color: scale < 1
    ? const Color(0xff406AD8)
    : const Color(0xAA3559B8),

                borderRadius: BorderRadius.circular(18),

                border: Border.all(
                  color: Colors.white24,
                ),

                boxShadow: [

  BoxShadow(
    color: Colors.black.withOpacity(.15),
    blurRadius: 8,
    offset: const Offset(0, 4),
  ),

  if (scale < 1)
    BoxShadow(
      color: Colors.white.withOpacity(.25),
      blurRadius: 18,
      spreadRadius: 2,
    ),

],

              ),

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal:18),

                child: Row(

                  children: [

                    Container(

                      width: 40,

                      height: 40,

                      decoration: BoxDecoration(

                        color: Colors.white12,

                        shape: BoxShape.circle,

                      ),

                     child: AnimatedScale(
    duration: const Duration(milliseconds: 120),
    scale: scale < 1 ? 1.15 : 1,
    child: Icon(
      widget.icon,
      color: Colors.white,
      size: 22,
    ),
                      ),

                    ),

                    const SizedBox(width:16),

                    Expanded(

                      child: Text(

                        widget.title,

                        style: GoogleFonts.schoolbell(

                          color: Colors.white,

                          fontSize: 22,

                        ),

                      ),

                    ),

                    AnimatedSlide(
  duration: const Duration(milliseconds: 150),
  offset: scale < 1
      ? const Offset(.15, 0)
      : Offset.zero,
  child: const Icon(
    Icons.arrow_forward_ios_rounded,
    color: Colors.white70,
    size: 18,
  ),
),

                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }

}