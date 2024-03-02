import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/views/pages/authentication/login_page.dart';
import 'package:tatwei/views/pages/student_panel/fursi/fursi_page.dart';
import 'package:tatwei/views/pages/student_panel/saati/saati_page.dart';
import 'package:tatwei/views/pages/student_panel/student_info/student_info_page.dart';
import 'package:tatwei/views/widgets/drawer_tile.dart';

class DrawerData extends StatefulWidget {
  const DrawerData({
    super.key,
  });

  @override
  State<DrawerData> createState() => _DrawerDataState();
}

class _DrawerDataState extends State<DrawerData> {
  StudentController studentController = Get.put(StudentController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    //   studentController.getStudentData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfff0ecac),
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            GetX<StudentController>(
                init: Get.put(StudentController()),
                builder: (cont) {
                  return cont.getstudentData.email == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Image.asset('assets/icons/profile.png'),
                              Text(cont.getstudentData.studenName!,
                                  style: GoogleFonts.inter(
                                      color: ColorClass.darkGreenColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        );
                }),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => StudentInfoPage()),
              title: 'حسابي',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => const FursiPage()),
              title: 'فرصي',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => const SaatiPage()),
              title: 'ساعاتي',
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
            SizedBox(height: Get.height * 0.1),
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
          ],
        ),
      ),
    );
  }
}
