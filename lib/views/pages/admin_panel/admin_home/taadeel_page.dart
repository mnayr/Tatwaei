import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/views/pages/admin_panel/admin_home/hazaf_page.dart';

class TaadeelPage extends StatefulWidget {
  const TaadeelPage({super.key});

  @override
  State<TaadeelPage> createState() => _TaadeelPageState();
}

class _TaadeelPageState extends State<TaadeelPage> {
  final TextEditingController detailController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController locationLinkController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController benefitController = TextEditingController();

  bool isDetail = false;
  bool isDays = false;
  bool isNumber = false;
  bool isType = false;
  bool isPlace = false;
  bool isLocation = false;
  bool isGender = false;
  bool isBenefit = false;
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
                        Row(
                          children: [
                            Text(
                              'تفاصيل الفرصة التطوعية ',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDetail = !isDetail;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            value: isDetail,
                            maxLines: 2,
                            controller: detailController,
                            hintText:
                                'التحقق من البيانات المقدمة و جمع بيانات حول احتياجات المستفيد و رصد جميع المتطلبات اللازمة'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '12 مارس - 30 مايو',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDays = !isDays;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            maxLines: 1,
                            value: isDays,
                            controller: daysController,
                            hintText: '79 يوم'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'المقاعد',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isNumber = !isNumber;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            maxLines: 1,
                            value: isNumber,
                            controller: numberController,
                            hintText: '35 مقعد'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'المجال التطوعي',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isType = !isType;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            maxLines: 1,
                            value: isType,
                            controller: typeController,
                            hintText: 'اجتماعية'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'مكان التطوع',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPlace = !isPlace;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            maxLines: 1,
                            value: isPlace,
                            controller: placeController,
                            hintText: 'هيئة الاحصاء'),
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
                        Row(
                          children: [
                            Text(
                              'الجنس',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 14),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isGender = !isGender;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            maxLines: 1,
                            value: isGender,
                            controller: genderController,
                            hintText: 'ذكر'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'الفوائة المكتسبة من الفرصة التطوعية',
                              style: GoogleFonts.inter(
                                  color: ColorClass.darkGreenColor,
                                  fontSize: 14),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isBenefit = !isBenefit;
                                  });
                                },
                                child: Image.asset('assets/icons/edit.png')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        EditField(
                            maxLines: 3,
                            value: isBenefit,
                            controller: benefitController,
                            hintText:
                                '-الثواب الاجر -\n-توثيق الساعات التطوعية  \n-المساهمة في خدمة المجتمع'),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'حفظ الحذف ؟',
                                  style: GoogleFonts.inter(
                                      color: ColorClass.darkGreenColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => TaadeelPage());
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 98,
                                        decoration: BoxDecoration(
                                          color: ColorClass.darkGreenColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'حفظ',
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    GestureDetector(
                                      onTap: () => Get.to(() => HazafPage()),
                                      child: Container(
                                        height: 35,
                                        width: 98,
                                        decoration: BoxDecoration(
                                          color: ColorClass.darkGreenColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'الغاء',
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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

class EditField extends StatelessWidget {
  const EditField({
    super.key,
    required this.value,
    required this.controller,
    required this.hintText,
    required this.maxLines,
  });

  final bool value;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: TextFormField(
        readOnly: value,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
