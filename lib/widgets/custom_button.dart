import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_details/constants/colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.isPressed,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Color? buttonColor =
        widget.isPressed ? scaffoldBackgroundColor : Colors.grey[200];

    return SizedBox(
      height: 46,
      width: 80,
      child: ElevatedButton(
        onPressed: widget.isPressed ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
