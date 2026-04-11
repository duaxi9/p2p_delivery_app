import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool filled;
  final VoidCallback? onTap;

  const MyButton({super.key, required this.text, this.filled = true, this.onTap}); // ← add onTap

  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // ← wrap with this
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF111111) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: filled ? const Color(0xFF111111) : const Color(0xFFB8960A),
            width: filled ? 0 : 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: filled ? Colors.white : const Color(0xFFB8960A),
            ),
          ),
        ),
      ),
    );
  }
}