import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/views/widgets/common_appbar.dart';
import 'package:tatwei/views/widgets/common_field.dart';

class StudentInfoPage extends StatelessWidget {
  StudentInfoPage({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppbar(title: 'حسابي'),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset('assets/icons/back_arrow.svg')),
              SizedBox(height: Get.height * 0.04),
              CommonField(
                  controller: nameController,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'الاسم'),
              const SizedBox(height: 10),
              CommonField(
                  controller: gradeController,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'الصف الدراسي'),
              const SizedBox(height: 10),
              CommonField(
                  controller: gradeController,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'اسم المدرسة',
                  isShowPrefix: false),
              const SizedBox(height: 10),
              CommonField(
                  controller: phoneController,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'رقم الجوال'),
              const SizedBox(height: 10),
              CommonField(
                  controller: mailController,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'البريد الاكتروني'),
              const SizedBox(height: 10),
              CommonField(
                  controller: passController,
                  prefixIcon: 'assets/icons/edit.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  isObscure: true,
                  title: 'كلمة المرور'),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 34,
                    width: Get.width * 0.2,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorClass.darkGreenColor.withOpacity(.4),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'حفظ',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
