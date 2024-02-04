import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({
    super.key,
    required this.title,
    required this.onTap,
    this.isIcon = false,
    required this.iconImage,
  });
  final String title;
  final VoidCallback onTap;
  bool isIcon;
  final String iconImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 40,
        color: const Color(0xffc5d786),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isIcon ? Image.asset(iconImage) : const SizedBox(),
              SizedBox(width: isIcon ? 10 : 0),
              Text(
                title,
                style: GoogleFonts.inter(
                    color: const Color(0xff0A2F5A),
                    fontSize: isIcon ? 16 : 24,
                    fontWeight: isIcon ? FontWeight.w400 : FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
