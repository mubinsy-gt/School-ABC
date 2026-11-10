import 'package:flutter/material.dart';

class ButtonNavigation extends StatefulWidget {
  final Widget iconImage;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback onPressed;

  const ButtonNavigation({
    super.key,
    required this.iconImage,
    required this.backgroundColor,
    required this.borderRadius,
    required this.onPressed,
  });

  @override
  State<ButtonNavigation> createState() => _ButtonNavigationState();
}

class _ButtonNavigationState extends State<ButtonNavigation> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      scale: scale,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),

          onTapDown: (_) {
            setState(() => scale = .90);
          },

          onTapCancel: () {
            setState(() => scale = 1);
          },

          onTapUp: (_) {
            setState(() => scale = 1);
            widget.onPressed();
          },

          child: Ink(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.20),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Container(
              width: 68,
              height: 68,
              alignment: Alignment.center,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 150),
                scale: scale < 1 ? 1.15 : 1,
                child: widget.iconImage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}