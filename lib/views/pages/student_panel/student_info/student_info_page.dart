import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/constants/maxin_validation.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/views/widgets/common_appbar.dart';
import 'package:tatwei/views/widgets/common_field.dart';

class StudentInfoPage extends StatefulWidget {
  StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage>
    with ValidationMixin {
  // final TextEditingController nameController = TextEditingController();

  // final TextEditingController gradeController = TextEditingController();

  // final TextEditingController phoneController = TextEditingController();

  // final TextEditingController mailController = TextEditingController();

  // final TextEditingController passController = TextEditingController();
  StudentController studentController = Get.put(StudentController());
  List<String> gradeOption = ['الصف الأول', 'الصف الثاني', 'الصف الثالث'];
  String _selectedgrade = 'الصف الأول';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    studentController.nameController.text =
        studentController.getstudentData.studenName!;
    _selectedgrade = studentController.getstudentData.studentGrade!;

    studentController.phoneController.text =
        studentController.getstudentData.phoneNumber!;

    studentController.mailController.text =
        studentController.getstudentData.email!;

    studentController.passController.text =
        studentController.getstudentData.password!;

    studentController.schoolNameController.text =
        studentController.getstudentData.schoolName!;

    // TODO: implement initState
    super.initState();
  }

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/icons/back_arrow.svg')),
                SizedBox(height: Get.height * 0.04),
                CommonField(
                    controller: studentController.nameController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'الاسم'),
                const SizedBox(height: 10),
                Text('الصف الدراسي', style: FontStyles.textFieldText),
                Container(
                  decoration: BoxDecoration(
                      color: ColorClass.primaryColor,
                      border: Border.all(
                          color: ColorClass.darkGreenColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(2),
                  child: DropdownButton(
                    // Initial Value
                    isExpanded: true,
                    underline: const SizedBox(),

                    value: _selectedgrade,

                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorClass.darkGreenColor,
                    ),

                    // Array list of genderList
                    items: gradeOption.map((String interest) {
                      return DropdownMenuItem(
                        value: interest,
                        child: Text(interest,
                            style: GoogleFonts.inter(
                                color: Colors.black, fontSize: 17)),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedgrade = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CommonField(
                    readOnly: true,
                    controller: studentController.schoolNameController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'اسم المدرسة',
                    isShowPrefix: false),
                const SizedBox(height: 10),
                CommonField(
                    controller: studentController.phoneController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'رقم الجوال'),
                const SizedBox(height: 10),
                CommonField(
                    readOnly: true,
                    isShowPrefix: false,
                    controller: studentController.mailController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'البريد الاكتروني'),
                const SizedBox(height: 10),
                CommonField(
                    controller: studentController.passController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    isObscure: true,
                    title: 'كلمة المرور'),
                Center(
                  child: Obx(
                    () => studentController.isEdit.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorClass.darkGreenColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                studentController
                                    .updateUserProfile(_selectedgrade);
                              }
                            },
                            child: Container(
                              height: 34,
                              width: Get.width * 0.2,
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color:
                                    ColorClass.darkGreenColor.withOpacity(.4),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
