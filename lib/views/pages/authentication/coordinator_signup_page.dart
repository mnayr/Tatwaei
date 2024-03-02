import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class CoordinatorSignupPage extends StatefulWidget {
  const CoordinatorSignupPage({super.key});

  @override
  State<CoordinatorSignupPage> createState() => _CoordinatorSignupPageState();
}

class _CoordinatorSignupPageState extends State<CoordinatorSignupPage>
    with ValidationMixin {
  List<String> instituteOption = ['A', 'B', 'C', 'D'];
  String? selectedInstitute;
  AdminController adminController = Get.put(AdminController());
  final formKey = GlobalKey<FormState>();
  List<String> schoolList = [
    'جامعة الملك عبدالعزيز',
    'جامعة الملك سعود',
    'جامعة الملك فهد للبترول والمعادن',
    'جامعة الأميرة نورة بنت عبدالرحمن',
    'جامعة الإمام محمد بن سعود الإسلامية',
    'جامعة الملك عبدالله للعلوم والتقنية',
    'جامعة دار الحكمة',
    'جامعة عفت',
    'جامعة الفيصل',
    'جامعة الملك خالد',
  ];

  void addSchooleName() async {
    for (int i = 0; i < schoolList.length; i++) {
      await FirebaseFirestore.instance.collection('schools_name').add({
        'school_name': schoolList[i],
        'date_time': DateTime.now(),
        'school_id': '',
      }).then((value) {
        FirebaseFirestore.instance
            .collection('schools_name')
            .doc(value.id)
            .update({
          'school_id': value.id,
        });
        print('add$i');
      });
    }
  }

  @override
  void initState() {
    adminController.getAllSchool();
    // TODO: implement initState
    super.initState();
  }

  SchoolsNameModel? schoolModel;

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
                  // ElevatedButton(
                  //     onPressed: () {
                  //       addSchooleName();
                  //     },
                  //     child: Text('add')),
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
                              schoolModel, // Use the selectedAuthor from the controller
                          underline: const SizedBox(),
                          items: cont.getSchoolList
                              .map((SchoolsNameModel schoolModel) {
                            return DropdownMenuItem<SchoolsNameModel>(
                              value: schoolModel,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  schoolModel.schoolName ?? "",
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
                              schoolModel = newValue;
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
                  SizedBox(height: Get.height * 0.01),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        AwesomeDialog(
                          dialogBackgroundColor: ColorClass.primaryColor,
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.question,
                          autoDismiss: true,
                          btnOk: SizedBox(
                            height: Get.height * 0.06,
                            width: Get.width,
                            child: CommonButton(
                              text: 'نعم',
                              backgroundColor: ColorClass.darkGreenColor,
                              onTap: () {},
                            ),
                          ),
                          body: Column(
                            children: [
                              CommonField(
                                controller:
                                    adminController.schoolNameController,
                                prefixIcon: 'prefixIcon',
                                onChanged: (value) {},
                                validator: (value) {
                                  return isFullNameValid(value!)
                                      ? null
                                      : 'Requried';
                                },
                                title: 'مدرسة',
                                isShowPrefix: false,
                              ),
                            ],
                          ),
                          btnOkOnPress: () {},
                        ).show();
                      },
                      child: Text(
                        ' لم اجد مدرستي ؟',
                        style: GoogleFonts.inter(
                            color: ColorClass.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  CommonField(
                    controller: adminController.schoolphoneContr,
                    prefixIcon: 'assets/icons/call-phone.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'رقم الهاتف',
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CommonField(
                    controller: adminController.schoollocationContr,
                    prefixIcon: 'assets/icons/pin.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'العنوان',
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CommonField(
                    controller: adminController.schoolMailContr,
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
                    controller: adminController.schoolPassContr,
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
                  Obx(
                    () => adminController.isSchoolRegister.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorClass.darkGreenColor,
                            ),
                          )
                        : CommonButton(
                            text: 'تسجيل',
                            backgroundColor: ColorClass.darkGreenColor,
                            onTap: () {
                              // addSchooleName();
                              if (formKey.currentState!.validate()) {
                                if (schoolModel == null) {
                                  DisplayMessage().errorMessage(
                                      'Please select the school name');
                                } else {
                                  adminController.registerSchool(schoolModel!);
                                }
                              }
                            },
                          ),
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
