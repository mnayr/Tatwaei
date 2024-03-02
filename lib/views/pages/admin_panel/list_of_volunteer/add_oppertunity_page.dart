import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/admin_constant.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/views/widgets/common_field.dart';

// ignore: must_be_immutable
class AddOppertunityPage extends StatelessWidget {
  AddOppertunityPage({super.key});
  TextEditingController oppertunityNameCntr = TextEditingController();
  TextEditingController oppertunityDetailsCntr = TextEditingController();
  TextEditingController startDataCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  TextEditingController totalSeatsCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController interestCtrl = TextEditingController();
  TextEditingController placeCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController benefitCtrl = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    ColorScheme.light(primary: ColorClass.darkGreenColor)),
            child: child!,
          );
        });

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  AuthController authController = Get.put(AuthController());

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
            'إضافة فرصه ',
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
                CommonField(
                  isBoldTitle: true,
                  isFilled: true,
                  controller: oppertunityNameCntr,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: ' الفرصة التطوعية ',
                ),
                SizedBox(height: Get.height * 0.01),
                CommonField(
                  isBoldTitle: true,
                  isFilled: true,
                  controller: oppertunityDetailsCntr,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'تفاصيل الفرصة التطوعية ',
                ),
                SizedBox(height: Get.height * 0.01),
                ElevatedButton(onPressed: () {}, child: Text('SELECT DATE')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonField(
                        isBoldTitle: true,
                        isFilled: true,
                        controller: startDataCtrl,
                        prefixIcon: 'assets/icons/edit.png',
                        onChanged: (value) {},
                        validator: (value) {
                          return '';
                        },
                        title: 'تاريخ البدايه',
                      ),
                    ),
                    SizedBox(width: Get.width * 0.1),
                    Expanded(
                      child: CommonField(
                        isBoldTitle: true,
                        isFilled: true,
                        controller: endDateCtrl,
                        prefixIcon: 'assets/icons/edit.png',
                        onChanged: (value) {},
                        validator: (value) {
                          return '';
                        },
                        title: 'تاريخ النهايه',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonField(
                        isBoldTitle: true,
                        isFilled: true,
                        controller: totalSeatsCtrl,
                        prefixIcon: 'assets/icons/edit.png',
                        onChanged: (value) {},
                        validator: (value) {
                          return '';
                        },
                        title: 'المقاعد ',
                      ),
                    ),
                    SizedBox(width: Get.width * 0.1),
                    Expanded(
                      child: CommonField(
                        isBoldTitle: true,
                        isFilled: true,
                        controller: genderCtrl,
                        prefixIcon: 'assets/icons/edit.png',
                        onChanged: (value) {},
                        validator: (value) {
                          return '';
                        },
                        title: 'الجنس',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                authController.auth.currentUser!.uid == AdminConstant.adminId
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CommonField(
                                  isBoldTitle: true,
                                  isFilled: true,
                                  controller: interestCtrl,
                                  prefixIcon: 'assets/icons/edit.png',
                                  onChanged: (value) {},
                                  validator: (value) {
                                    return '';
                                  },
                                  title: 'المجال التطوعي',
                                ),
                              ),
                              SizedBox(width: Get.width * 0.1),
                              Expanded(
                                child: CommonField(
                                  isBoldTitle: true,
                                  isFilled: true,
                                  controller: placeCtrl,
                                  prefixIcon: 'assets/icons/edit.png',
                                  onChanged: (value) {},
                                  validator: (value) {
                                    return '';
                                  },
                                  title: 'مكان التطوع',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.01),
                          CommonField(
                            isBoldTitle: true,
                            isFilled: true,
                            controller: locationCtrl,
                            prefixIcon: 'assets/icons/edit.png',
                            onChanged: (value) {},
                            validator: (value) {
                              return '';
                            },
                            title: 'الموقع',
                          ),
                          SizedBox(height: Get.height * 0.01),
                        ],
                      )
                    : SizedBox(),
                CommonField(
                  isBoldTitle: true,
                  isFilled: true,
                  controller: benefitCtrl,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'الفوائة المكتسبة من الفرصة التطوعية',
                ),
                Text('صوره',
                    style:
                        GoogleFonts.inter(color: Colors.black, fontSize: 17)),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorClass.primaryColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/icons/imagepick.png'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
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
                              onTap: () {},
                              child: Container(
                                height: 35,
                                width: 98,
                                decoration: BoxDecoration(
                                  color: ColorClass.darkGreenColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Text(
                                    'حفظ',
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 35,
                                width: 98,
                                decoration: BoxDecoration(
                                  color: ColorClass.darkGreenColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Text(
                                    'الغاء',
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 20),
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
      ),
    );
  }
}
