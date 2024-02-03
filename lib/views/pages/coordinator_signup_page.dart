import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/views/widgets/common_button.dart';
import 'package:tatwei/views/widgets/common_field.dart';
import 'package:tatwei/views/widgets/custom_dropdown.dart';

class CoordinatorSignupPage extends StatefulWidget {
  const CoordinatorSignupPage({super.key});

  @override
  State<CoordinatorSignupPage> createState() => _CoordinatorSignupPageState();
}

class _CoordinatorSignupPageState extends State<CoordinatorSignupPage> {
  List<String> instituteOption = ['A', 'B', 'C', 'D'];
  String? _selectedInstitute;

  final TextEditingController locationContr = TextEditingController();
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
                  'انشاء حساب\nمدرسة',
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
                  controller: locationContr,
                  prefixIcon: 'assets/icons/pin.png',
                  onChanged: (value) {},
                  validator: (value) {
                    return '';
                  },
                  title: 'العنوان',
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