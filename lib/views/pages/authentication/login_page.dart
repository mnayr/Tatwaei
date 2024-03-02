import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/constants/maxin_validation.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/views/pages/admin_panel/admin_home/admin_home_page.dart';
import 'package:tatwei/views/pages/authentication/student_signup_page.dart';
import 'package:tatwei/views/pages/authentication/coordinator_signup_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/teacher_home/teacher_home_page.dart';
import 'package:tatwei/views/pages/student_panel/home/home_page.dart';
import 'package:tatwei/views/widgets/common_button.dart';
import 'package:tatwei/views/widgets/common_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  AuthController authController = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    clearUser();
    // TODO: implement initState
    super.initState();
  }

  clearUser() async {
    await authController.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                        controller: authController.loginEmail,
                        prefixIcon: 'assets/icons/email.png',
                        onChanged: (value) {},
                        validator: (email) {
                          return isEmailValid(email!)
                              ? null
                              : 'Invalid email address';
                        },
                        title: 'البريد الالكتروني',
                      ),
                      SizedBox(height: Get.height * 0.01),
                      CommonField(
                        controller: authController.loginPasswordController,
                        title: 'كلمة المرور',
                        prefixIcon: 'assets/icons/lock.png',
                        onChanged: (value) {},
                        validator: (password) {
                          return isPasswordValid(password!)
                              ? null
                              : 'Password must greater then or equal to 8 characters';
                        },
                        isObscure: true,
                      ),
                      SizedBox(height: Get.height * 0.05),
                      Obx(
                        () => authController.isUserLogin.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorClass.primaryColor,
                                ),
                              )
                            : CommonButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.login(context);
                                  }
                                  // if (mailContr.text == 'student@gmail.com' &&
                                  //     passContr.text == '123456') {
                                  //   Get.offAll(() => const HomePage());
                                  // } else if (mailContr.text == 'admin@gmail.com' &&
                                  //     passContr.text == '123456') {
                                  //   Get.offAll(() => AdminHomePage());
                                  // } else if (mailContr.text == 'teacher@gmail.com' &&
                                  //     passContr.text == '123456') {
                                  //   Get.offAll(() => TeacherHomePage());
                                  // }
                                },
                                text: 'تسجيل الدخول',
                                backgroundColor: const Color(0xff0C5579),
                              ),
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
      ),
    );
  }
}
