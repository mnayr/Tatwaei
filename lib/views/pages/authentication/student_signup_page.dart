import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/display_message.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/constants/maxin_validation.dart';
import 'package:tatwei/controllers/admin_controller.dart';
import 'package:tatwei/model/schools_name_model.dart';
import 'package:tatwei/views/widgets/common_button.dart';
import 'package:tatwei/views/widgets/common_field.dart';
import 'package:tatwei/views/widgets/custom_dropdown.dart';

class StudentSignupPage extends StatefulWidget {
  const StudentSignupPage({super.key});

  @override
  State<StudentSignupPage> createState() => _StudentSignupPageState();
}

class _StudentSignupPageState extends State<StudentSignupPage>
    with ValidationMixin {
  List<String> instituteOption = ['A', 'B', 'C', 'D'];
  String? _selectedInstitute;

  List<String> gradeOption = ['الصف الأول', 'الصف الثاني', 'الصف الثالث'];
  String? _selectedgrade;
  AdminController adminController = Get.put(AdminController());

  SchoolsNameModel? selectedSchool;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    adminController.getAllRegisterSchool();
    // TODO: implement initState
    super.initState();
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
                  GetX<AdminController>(
                    init: Get.put(AdminController()),
                    builder: (cont) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorClass.darkGreenColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<SchoolsNameModel>(
                          iconEnabledColor: ColorClass.darkGreenColor,
                          isExpanded: true,
                          value:
                              selectedSchool, // Use the selectedAuthor from the controller
                          underline: const SizedBox(),
                          items: cont.getRegisterSchoolList
                              .map((SchoolsNameModel selectedSchool) {
                            return DropdownMenuItem<SchoolsNameModel>(
                              value: selectedSchool,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedSchool.schoolName ?? "",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (SchoolsNameModel? newValue) {
                            // Use a different variable name here
                            setState(() {
                              selectedSchool = newValue;
                            });
                            //  cont.onAuthorSelected(selectedAuthor); // Call the method in the controller
                          },
                          hint: Text(
                            '',
                            style: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // CustomDropDown(
                  //     selectedInstitute: _selectedInstitute,
                  //     instituteOption: instituteOption),
                  SizedBox(height: Get.height * 0.02),
                  CommonField(
                    controller: adminController.studentNameController,
                    prefixIcon: 'assets/icons/person.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
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
                  CustomDropDown(instituteOption: gradeOption),
                  SizedBox(height: Get.height * 0.02),
                  CommonField(
                    controller: adminController.studentphoneContr,
                    prefixIcon: 'assets/icons/call-phone.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'رقم الهاتف',
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CommonField(
                    controller: adminController.studentMailContr,
                    prefixIcon: 'assets/icons/email.png',
                    onChanged: (value) {},
                    validator: (email) {
                      return isEmailValid(email!)
                          ? null
                          : 'Invalid email address';
                    },
                    title: 'البريد الالكتروني',
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CommonField(
                    controller: adminController.studentPassContr,
                    prefixIcon: 'assets/icons/lock.png',
                    onChanged: (value) {},
                    validator: (password) {
                      return isPasswordValid(password!)
                          ? null
                          : 'Password must greater then or equal to 8 characters';
                    },
                    title: 'كلمة المرور',
                    isObscure: true,
                  ),
                  SizedBox(height: Get.height * 0.03),
                  CommonButton(
                    text: 'تسجيل',
                    backgroundColor: ColorClass.darkGreenColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (selectedSchool == null) {
                          DisplayMessage()
                              .errorMessage('Please select the school name');
                        } else if (adminController.selectedGrade == null) {
                          DisplayMessage()
                              .errorMessage('Please select the Student grade');
                        } else {
                          adminController.registerStudent(
                              adminController.selectedGrade!, selectedSchool!);
                        }
                      }
                    },
                  ),
                  SizedBox(height: Get.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
