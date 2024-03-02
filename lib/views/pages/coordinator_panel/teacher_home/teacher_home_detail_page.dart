import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';

class TeacherHomeDetailPage extends StatelessWidget {
  const TeacherHomeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/icons/fursi.png',
              ),
            );
          }),
          title: Text(
            'تفاصيل الفرص ',
            style: GoogleFonts.inter(color: Colors.black, fontSize: 32),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          actions: [
            Image.asset('assets/icons/logo_text.png'),
          ],
          iconTheme: const IconThemeData(color: Color(0xffD3CA25)),
          backgroundColor: const Color(0xffD3CA25).withOpacity(.3),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/icons/back_arrow.svg')),
                SizedBox(height: Get.height * 0.02),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorClass.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          // width: Get.width * 0.6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: ColorClass.darkGreenColor.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'باحث ميداني ',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'تفاصيل الفرصة التطوعية ',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'التحقق من البيانات المقدمة و جمع بيانات حول احتياجات المستفيد و رصد جميع المتطلبات اللازمة',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '12 مارس - 30 مايو',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '79 يوم',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'المقاعد',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '35 مقعد',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'المجال التطوعي',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'اجتماعية',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'مكان التطوع',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'هيئة الاحصاء',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'الموقع',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'https://maps.app.goo.gl/8KkdepLQwDdq8qfH9?g_st=iw',
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'الجنس',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ذكر',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'الفوائة المكتسبة من الفرصة التطوعية',
                          style: GoogleFonts.inter(
                              color: ColorClass.darkGreenColor, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '-الثواب الاجر -\n-توثيق الساعات التطوعية  \n-المساهمة في خدمة المجتمع',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Get.to(
                                //     () => const TeacherOppertunityDetailPage());
                              },
                              child: Container(
                                height: 35,
                                width: 98,
                                decoration: BoxDecoration(
                                  color: ColorClass.darkGreenColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'تحرير',
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
