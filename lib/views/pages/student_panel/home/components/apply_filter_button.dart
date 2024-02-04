import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyFilterButton extends StatelessWidget {
  const ApplyFilterButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20,
        width: 76,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff7EB347).withOpacity(.38)),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
