import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/views/pages/authentication/student_signup_page.dart';
import 'package:tatwei/views/pages/authentication/coordinator_signup_page.dart';
import 'package:tatwei/views/pages/student_panel/home/home_page.dart';
import 'package:tatwei/views/widgets/common_button.dart';
import 'package:tatwei/views/widgets/common_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController mailContr = TextEditingController();
  final TextEditingController passContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.06),
                Text(
                  'مرحبا بك في\n تطوعي',
                  textAlign: TextAlign.center,
                  style: FontStyles.boldText,
                ),
                SizedBox(height: Get.height * 0.02),
                Image.asset('assets/icons/logo.png'),
                SizedBox(height: Get.height * 0.02),
                Text(
                  'سجل دخولك',
                  textAlign: TextAlign.center,
                  style: FontStyles.boldText,
                ),
                SizedBox(height: Get.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonField(
                      controller: mailContr,
                      prefixIcon: 'assets/icons/email.png',
                      onChanged: (value) {},
                      validator: (value) {
                        return '';
                      },
                      title: 'البريد الالكتروني',
                    ),
                    SizedBox(height: Get.height * 0.01),
                    CommonField(
                      controller: passContr,
                      title: 'كلمة المرور',
                      prefixIcon: 'assets/icons/lock.png',
                      onChanged: (value) {},
                      validator: (value) {
                        return '';
                      },
                      isObscure: true,
                    ),
                    SizedBox(height: Get.height * 0.05),
                    CommonButton(
                      onTap: () {
                        Get.offAll(() => const HomePage());
                        // if (mailContr.text == 'student@gmail.com' &&
                        //     passContr.text == '123456') {
                        //   Get.offAll(() => const HomePage());
                        // } else {
                        //   Get.snackbar('Error', 'Enter correct credentials');
                        // }
                      },
                      text: 'تسجيل الدخول',
                      backgroundColor: const Color(0xff0C5579),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: FontStyles.normalText,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: ColorClass.darkGreenColor,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('أو',
                            style: GoogleFonts.roboto(
                                color: ColorClass.darkGreenColor,
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Divider(
                            color: ColorClass.darkGreenColor,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CommonButton(
                  onTap: () => Get.to(() => const StudentSignupPage()),
                  text: 'انشاء حساب طالب',
                  backgroundColor: const Color(0xff0C5579),
                ),
                const SizedBox(height: 15),
                CommonButton(
                  onTap: () => Get.to(() => const CoordinatorSignupPage()),
                  text: 'انشاء حساب مدرسة',
                  backgroundColor: const Color(0xff0C5579),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
