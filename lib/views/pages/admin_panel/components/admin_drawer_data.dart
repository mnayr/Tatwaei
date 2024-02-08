import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/views/pages/authentication/login_page.dart';
import 'package:tatwei/views/pages/student_panel/fursi/fursi_page.dart';
import 'package:tatwei/views/pages/student_panel/saati/saati_page.dart';
import 'package:tatwei/views/pages/student_panel/student_info/student_info_page.dart';
import 'package:tatwei/views/widgets/drawer_tile.dart';

class AdminDrawerData extends StatelessWidget {
  const AdminDrawerData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfff0ecac),
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Image.asset('assets/icons/profile.png'),
                  Text('نورة',
                      style: GoogleFonts.inter(
                          color: ColorClass.darkGreenColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () {},
              title: 'فرص التطوع',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.offAll(() => LoginPage()),
              title: 'تسجيل خروج',
              iconImage: '',
            ),
            const Spacer(),
            // SizedBox(height: Get.height * 0.1),
            DrawerTile(
              onTap: () {},
              title: 'تواصل معنا ',
              iconImage: '',
            ),
            DrawerTile(
              onTap: () {},
              title: 'ContactTatwaei@gmail.com',
              iconImage: 'assets/icons/mail.png',
              isIcon: true,
            ),
            DrawerTile(
              onTap: () {},
              title: 'ContactTatwaei',
              iconImage: 'assets/icons/x.png',
              isIcon: true,
            ),
            SizedBox(height: Get.height * 0.1),
          ],
        ),
      ),
    );
  }
}