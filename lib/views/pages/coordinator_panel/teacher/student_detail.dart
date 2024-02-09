import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/model/hours_model.dart';

class TeacherStudentDetailPage extends StatefulWidget {
  const TeacherStudentDetailPage({
    super.key,
    required this.studData,
  });
  final HoursModel studData;

  @override
  State<TeacherStudentDetailPage> createState() =>
      _TeacherStudentDetailPageState();
}

class _TeacherStudentDetailPageState extends State<TeacherStudentDetailPage> {
  bool isShowPopUP = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/logo_text.png'),
          )
        ],
        backgroundColor: const Color(0xffD3CA25).withOpacity(.3),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icons/request.png'),
        ),
        title: Text(
          'طلابي',
          style: FontStyles.boldText,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset('assets/icons/back_arrow.svg')),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      Container(
                        // width: Get.width * 0.6,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorClass.darkGreenColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            widget.studData.name,
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      Container(
                        // width: Get.width * 0.6,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorClass.darkGreenColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            widget.studData.id,
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 31,
                          width: 116,
                          // padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: ColorClass.darkGreenColor.withOpacity(.4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'الحالية',
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowPopUP = true;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: 116,
                          // padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: ColorClass.darkGreenColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'المكتملة',
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ColorClass.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/4.png'),
                            ),
                            SizedBox(width: Get.width * 0.02),
                            Container(
                              // width: Get.width * 0.6,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              decoration: BoxDecoration(
                                color:
                                    ColorClass.darkGreenColor.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'تنظيم الطابور الصباحي',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 19,
                                width: 64,
                                // padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color:
                                      ColorClass.darkGreenColor.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'داخلية',
                                    style: GoogleFonts.inter(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width * 0.03),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 19,
                                width: 64,
                                // padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color:
                                      ColorClass.darkGreenColor.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'خدمية',
                                    style: GoogleFonts.inter(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                ],
              ),
              isShowPopUP
                  ? Container(
                      height: 281,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xffeeecb2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isShowPopUP = false;
                                  });
                                },
                                child:
                                    Image.asset('assets/icons/x-circle.png')),
                            SizedBox(height: Get.height * 0.02),
                            Center(child: Image.asset('assets/images/cer.png')),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
