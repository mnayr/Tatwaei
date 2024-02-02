import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/views/widgets/common_button.dart';
import 'package:tatwei/views/widgets/common_field.dart';
import 'package:tatwei/views/widgets/custom_dropdown.dart';

class StudentSignupPage extends StatefulWidget {
  const StudentSignupPage({super.key});

  @override
  State<StudentSignupPage> createState() => _StudentSignupPageState();
}

class _StudentSignupPageState extends State<StudentSignupPage> {
  List<String> instituteOption = ['A', 'B', 'C', 'D'];
  String? _selectedInstitute;

  List<String> gradeOption = ['1', '2', '3', '4'];
  String? _selectedgrade;
  final TextEditingController nameContr = TextEditingController();
  final TextEditingController gradeContr = TextEditingController();
  final TextEditingController phoneContr = TextEditingController();
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
                Image.asset('assets/icons/logo.png'),
                Text(
                  'انشاء حساب\nطالب',
                  textAlign: TextAlign.center,
                  style: FontStyles.boldText,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'المدرسة',
                      style: FontStyles.textFieldText,
                    )),
                CustomDropDown(
                    selectedInstitute: _selectedInstitute,
                    instituteOption: instituteOption),
                SizedBox(height: Get.height * 0.02),
                CommonField(
                  controller: nameContr,
                  prefixIcon: 'assets/icons/person.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'الاسم',
                ),
                SizedBox(height: Get.height * 0.02),
                Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'الصف الدراسي',
                      style: FontStyles.textFieldText,
                    )),
                CustomDropDown(
                    selectedInstitute: _selectedgrade,
                    instituteOption: gradeOption),
                SizedBox(height: Get.height * 0.02),
                CommonField(
                  controller: phoneContr,
                  prefixIcon: 'assets/icons/call-phone.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'رقم الهاتف',
                ),
                SizedBox(height: Get.height * 0.02),
                CommonField(
                  controller: mailContr,
                  prefixIcon: 'assets/icons/email.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'البريد الالكتروني',
                ),
                SizedBox(height: Get.height * 0.02),
                CommonField(
                  controller: mailContr,
                  prefixIcon: 'assets/icons/lock.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'كلمة المرور',
                  isObscure: true,
                ),
                SizedBox(height: Get.height * 0.03),
                CommonButton(
                  text: 'تسجيل',
                  backgroundColor: ColorClass.darkGreenColor,
                  onTap: () {},
                ),
                SizedBox(height: Get.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
