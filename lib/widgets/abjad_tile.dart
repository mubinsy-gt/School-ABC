import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AbjadTile extends StatefulWidget {
  final String abjad;
  final VoidCallback onPressed;

  const AbjadTile({
    super.key,
    required this.abjad,
    required this.onPressed,
  });

  @override
  State<AbjadTile> createState() => _AbjadTileState();
}

class _AbjadTileState extends State<AbjadTile> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: scale,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTapDown: (_) {
            setState(() {
              scale = .96;
            });
          },
          onTapCancel: () {
            setState(() {
              scale = 1;
            });
          },
          onTapUp: (_) {
            setState(() {
              scale = 1;
            });
            widget.onPressed();
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xAA3559B8),
                  Color(0xCC4F73D8),
                ],
              ),
              border: Border.all(
                color: Colors.white24,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 10,
                  offset: const Offset(0,5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_stories_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Text(
                    widget.abjad,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceWidth <= 360 ? 28 : 34,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Belajar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}