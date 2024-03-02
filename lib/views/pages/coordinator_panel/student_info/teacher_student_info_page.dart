import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/maxin_validation.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/views/widgets/common_appbar.dart';
import 'package:tatwei/views/widgets/common_field.dart';

// ignore: must_be_immutable
class TeacherStudentInfoPage extends StatefulWidget {
  TeacherStudentInfoPage({
    super.key,
  });

  @override
  State<TeacherStudentInfoPage> createState() => _TeacherStudentInfoPageState();
}

class _TeacherStudentInfoPageState extends State<TeacherStudentInfoPage>
    with ValidationMixin {
  SchoolController schoolController = Get.put(SchoolController());

  @override
  void initState() {
    schoolController.nameController.text =
        schoolController.getSchoolData.schoolName!;

    schoolController.phoneController.text =
        schoolController.getSchoolData.phoneNumber!;

    schoolController.mailController.text =
        schoolController.getSchoolData.email!;

    schoolController.passController.text =
        schoolController.getSchoolData.password!;
    schoolController.locationController.text =
        schoolController.getSchoolData.address!;

    // TODO: implement initState
    super.initState();
  }

  bool isNameField = true;
  bool isPhoneField = true;
  bool isMailField = true;
  bool isPsswordField = true;
  bool isAdressField = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    onTap: () {
                      setState(() {
                        isNameField = !isNameField;
                      });
                    },
                    isFilled: true,
                    controller: schoolController.nameController,
                    prefixIcon: 'assets/icons/edit.png',
                    readOnly: isNameField,
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'الاسم'),
                const SizedBox(height: 10),
                CommonField(
                    onTap: () {
                      setState(() {
                        isPhoneField = !isPhoneField;
                      });
                    },
                    readOnly: isPhoneField,
                    isFilled: true,
                    controller: schoolController.phoneController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'رقم الجوال'),
                const SizedBox(height: 10),
                CommonField(
                    isShowPrefix: false,
                    onTap: () {
                      setState(() {
                        isMailField = !isMailField;
                      });
                    },
                    readOnly: true,
                    isFilled: true,
                    controller: schoolController.mailController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (email) {
                      return isEmailValid(email!)
                          ? null
                          : 'Invalid email address';
                    },
                    title: 'البريد الاكتروني'),
                const SizedBox(height: 10),
                CommonField(
                    onTap: () {
                      setState(() {
                        isPsswordField = !isPsswordField;
                      });
                    },
                    readOnly: isPsswordField,
                    isFilled: true,
                    controller: schoolController.passController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (password) {
                      return isPasswordValid(password!)
                          ? null
                          : 'Password must greater then or equal to 8 characters';
                    },
                    isObscure: true,
                    title: 'كلمة المرور'),
                const SizedBox(height: 10),
                CommonField(
                    onTap: () {
                      setState(() {
                        isAdressField = !isAdressField;
                      });
                    },
                    readOnly: isAdressField,
                    isFilled: true,
                    controller: schoolController.locationController,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'العنوان',
                    isShowPrefix: true),
                const SizedBox(height: 10),
                Center(
                  child: Obx(
                    () => schoolController.isEdit.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorClass.darkGreenColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                schoolController.editSchooldata();
                              }
                              //schoolController.editSchooldata();
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
