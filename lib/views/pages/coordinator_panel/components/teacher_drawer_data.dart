import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/views/pages/admin_panel/list_of_volunteer/list_of_volunteer_page.dart';
import 'package:tatwei/views/pages/authentication/login_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/request/request_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/student_info/teacher_student_info_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/teacher/teacher_page.dart';
import 'package:tatwei/views/widgets/drawer_tile.dart';

class TeacherDrawerData extends StatelessWidget {
  TeacherDrawerData({
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
                  GetX<SchoolController>(
                      init: Get.put(SchoolController()),
                      builder: (cont) {
                        return cont.getSchoolData.email == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(cont.getSchoolData.schoolName!,
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
              onTap: () => Get.to(() => TeacherStudentInfoPage()),
              title: 'حسابي',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => TeacherPage()),
              title: 'طلابي',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => const RequestPage()),
              title: 'توثيق الطلاب',
              iconImage: '',
            ),
            SizedBox(height: Get.height * 0.06),
            DrawerTile(
              onTap: () => Get.to(() => const ListofVolunteerPage()),
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
