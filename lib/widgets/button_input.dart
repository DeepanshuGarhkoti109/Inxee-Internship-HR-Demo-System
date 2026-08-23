import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonInput extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const ButtonInput({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.white,
                letterSpacing: .5,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
