import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/admin_controller.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/views/pages/admin_panel/list_of_volunteer/list_of_volunteer_page.dart';
import 'package:tatwei/views/pages/authentication/login_page.dart';
import 'package:tatwei/views/widgets/drawer_tile.dart';

class AdminDrawerData extends StatelessWidget {
  AdminDrawerData({
    super.key,
  });

  final AuthController authController = Get.put(AuthController());

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
                  GetX<AdminController>(
                      init: Get.put(AdminController()),
                      builder: (cont) {
                        return cont.getAdminData.adminMail == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(cont.getAdminData.adminName!,
                                style: GoogleFonts.inter(
                                    color: ColorClass.darkGreenColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600));
                      }),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => ListofVolunteerPage()),
              title: 'فرص التطوع',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () {
                authController.logOut();
              },
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
