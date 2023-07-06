import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const SaveButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF8FC045),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
