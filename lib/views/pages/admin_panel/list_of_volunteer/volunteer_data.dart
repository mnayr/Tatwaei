import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tatwei/constants/admin_constant.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/display_message.dart';
import 'package:tatwei/constants/maxin_validation.dart';
import 'package:tatwei/controllers/auth_controller.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/views/widgets/common_field.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class VolunteerDataPage extends StatefulWidget {
  VolunteerDataPage({super.key, this.oppertunityModel});

  OppertunityModel? oppertunityModel;

  @override
  State<VolunteerDataPage> createState() => _VolunteerDataPageState();
}

class _VolunteerDataPageState extends State<VolunteerDataPage>
    with ValidationMixin {
  DateTime? _startDate;

  DateTime? _endDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate!.add(const Duration(days: 1)),
      firstDate: _startDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd')
        .format(date); // Format to show only month and day
  }

  String gender = 'ذكر';

  // List of genderList in our dropdown menu
  var genderList = [
    'ذكر',
    'انثى',
  ];

  var interestList = [
    'خدمية',
    'ادارية',
    'اجتماعية',
    'صحية',
    'اخرى',
  ];
  String interest = 'خدمية';

  File? _image;
  String? imageName;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageName = _image?.uri.pathSegments.last;
      } else {
        print('No image selected.');
      }
    });
  }

  final formKey = GlobalKey<FormState>();

  SchoolController schoolController = Get.put(SchoolController());
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    if (widget.oppertunityModel != null) {
      schoolController.oppertunityNameCntr.text =
          widget.oppertunityModel!.oppertunityName!;
      schoolController.oppertunityDetailsCntr.text =
          widget.oppertunityModel!.oppertunityDetail!;
      _startDate = DateTime.parse(widget.oppertunityModel!.startTime!);
      _endDate = DateTime.parse(widget.oppertunityModel!.endTime!);
      schoolController.totalSeatsCtrl.text =
          widget.oppertunityModel!.totalSeats!;
      interest = widget.oppertunityModel!.interest!;
      gender = widget.oppertunityModel!.gender!;
      schoolController.noOfHours.text = widget.oppertunityModel!.noOfHours!;
      schoolController.benefitCtrl.text = widget.oppertunityModel!.benefits!;
      imageName = widget.oppertunityModel!.imageName!;
      schoolController.linkCtrl.text = widget.oppertunityModel!.link!;
      schoolController.addressCtrl.text = widget.oppertunityModel!.address!;
    }
    // TODO: implement initState
    super.initState();
  }

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
            widget.oppertunityModel == null ? 'إضافة فرصه ' : 'تفاصيل الفرص ',
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
            child: Form(
              key: formKey,
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
                    controller: schoolController.oppertunityNameCntr,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: ' الفرصة التطوعية ',
                  ),
                  SizedBox(height: Get.height * 0.01),
                  CommonField(
                    isBoldTitle: true,
                    isFilled: true,
                    controller: schoolController.oppertunityDetailsCntr,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'تفاصيل الفرصة التطوعية ',
                  ),
                  SizedBox(height: Get.height * 0.01),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text('Start Date: ${_formatDate(_startDate)}'),
                  //         SizedBox(height: 20),
                  //         ElevatedButton(
                  //           onPressed: () => _selectStartDate(context),
                  //           child: Text('Select Start Date'),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text('End Date: ${_formatDate(_endDate)}'),
                  //         SizedBox(height: 20),
                  //         ElevatedButton(
                  //           onPressed: () => _selectEndDate(context),
                  //           child: Text('Select End Date'),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تاريخ البدايه',
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 17)),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.40,
                            decoration: BoxDecoration(
                              color: ColorClass.primaryColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _selectStartDate(context);
                                    },
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: ColorClass.darkGreenColor,
                                    ),
                                  ),
                                  Text(_startDate == null
                                      ? ''
                                      : _formatDate(_startDate!)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تاريخ النهايه',
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 17)),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.40,
                            decoration: BoxDecoration(
                              color: ColorClass.primaryColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_startDate == null) {
                                        DisplayMessage().errorMessage(
                                            'Please select start date first');
                                      }
                                      _selectEndDate(context);
                                    },
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: ColorClass.darkGreenColor,
                                    ),
                                  ),
                                  Text(_endDate == null
                                      ? ''
                                      : _formatDate(_endDate!)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: CommonField(
                  //         isBoldTitle: true,
                  //         isFilled: true,
                  //         controller: startDataCtrl,
                  //         prefixIcon: 'assets/icons/edit.png',
                  //         onChanged: (value) {},
                  //         validator: (value) {
                  //           return '';
                  //         },
                  //         title: 'تاريخ البدايه',
                  //       ),
                  //     ),
                  //     SizedBox(width: Get.width * 0.1),
                  //     Expanded(
                  //       child: CommonField(
                  //         isBoldTitle: true,
                  //         isFilled: true,
                  //         controller: endDateCtrl,
                  //         prefixIcon: 'assets/icons/edit.png',
                  //         onChanged: (value) {},
                  //         validator: (value) {
                  //           return '';
                  //         },
                  //         title: 'تاريخ النهايه',
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: Get.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CommonField(
                          isBoldTitle: true,
                          isFilled: true,
                          controller: schoolController.totalSeatsCtrl,
                          prefixIcon: 'assets/icons/edit.png',
                          validator: (value) {
                            return isFullNameValid(value!) ? null : 'Requried';
                          },
                          onChanged: (value) {},
                          title: 'المقاعد ',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text('المجال التطوعي',
                      style:
                          GoogleFonts.inter(color: Colors.black, fontSize: 17)),

                  Container(
                    decoration: BoxDecoration(
                        color: ColorClass.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(2),
                    child: DropdownButton(
                      // Initial Value
                      isExpanded: true,
                      underline: const SizedBox(),

                      value: interest,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorClass.darkGreenColor,
                      ),

                      // Array list of genderList
                      items: interestList.map((String interest) {
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
                          interest = newValue!;
                        });
                      },
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: CommonField(
                  //         isBoldTitle: true,
                  //         isFilled: true,
                  //         controller: interestCtrl,
                  //         prefixIcon: 'assets/icons/edit.png',
                  //         onChanged: (value) {},
                  //         validator: (value) {
                  //           return isFullNameValid(value!) ? null : 'Requried';
                  //         },
                  //         title: 'المجال التطوعي',
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: Get.height * 0.01),
                  Text('الجنس',
                      style:
                          GoogleFonts.inter(color: Colors.black, fontSize: 17)),

                  Container(
                    decoration: BoxDecoration(
                        color: ColorClass.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(2),
                    child: DropdownButton(
                      // Initial Value
                      isExpanded: true,
                      underline: const SizedBox(),

                      value: gender,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorClass.darkGreenColor,
                      ),

                      // Array list of genderList
                      items: genderList.map((String genderList) {
                        return DropdownMenuItem(
                          value: genderList,
                          child: Text(genderList,
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 17)),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                    ),
                  ),
                  // CommonField(
                  //   isBoldTitle: true,
                  //   isFilled: true,
                  //   controller: locationCtrl,
                  //   prefixIcon: 'assets/icons/edit.png',
                  //   onChanged: (value) {},
                  //   validator: (value) {
                  //     return '';
                  //   },
                  //   title: 'الجنس',
                  // ),
                  SizedBox(height: Get.height * 0.01),
                  CommonField(
                    textInputType: TextInputType.number,
                    isBoldTitle: true,
                    isFilled: true,
                    controller: schoolController.noOfHours,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
                    },
                    title: 'عدد الساعات',
                  ),

                  SizedBox(height: Get.height * 0.01),
                  authController.auth.currentUser!.uid == AdminConstant.adminId
                      ? Column(
                          children: [
                            CommonField(
                              isBoldTitle: true,
                              isFilled: true,
                              controller: schoolController.addressCtrl,
                              prefixIcon: 'assets/icons/edit.png',
                              onChanged: (value) {},
                              validator: (value) {
                                return isFullNameValid(value!)
                                    ? null
                                    : 'Requried';
                              },
                              title: 'مكان التطوع',
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CommonField(
                              isBoldTitle: true,
                              isFilled: true,
                              controller: schoolController.linkCtrl,
                              prefixIcon: 'assets/icons/edit.png',
                              onChanged: (value) {},
                              validator: (value) {
                                return isFullNameValid(value!)
                                    ? null
                                    : 'Requried';
                              },
                              title: 'الموقع',
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: Get.height * 0.01),

                  CommonField(
                    isBoldTitle: true,
                    isFilled: true,
                    controller: schoolController.benefitCtrl,
                    prefixIcon: 'assets/icons/edit.png',
                    onChanged: (value) {},
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'Requried';
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(imageName == null ? '' : imageName!),
                          GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: Image.asset('assets/icons/imagepick.png')),
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
                              Obx(
                                () => schoolController.isOppertunityAdd.value ||
                                        schoolController.isEditOpportunity.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: ColorClass.darkGreenColor,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (_startDate == null ||
                                                _endDate == null) {
                                              DisplayMessage().errorMessage(
                                                  'Please select the start time and end time of this opportunity');
                                            } else if (imageName == null &&
                                                imageName == null) {
                                              DisplayMessage().errorMessage(
                                                  'Please select the certificate image');
                                            } else {
                                              if (widget.oppertunityModel ==
                                                  null) {
                                                schoolController.addOppertunity(
                                                    startTime:
                                                        _startDate.toString(),
                                                    endTime:
                                                        _endDate.toString(),
                                                    gender: gender,
                                                    interest: interest,
                                                    imageName: imageName!,
                                                    file: _image!);
                                              } else {
                                                schoolController
                                                    .editOppertunity(
                                                  startTime:
                                                      _startDate.toString(),
                                                  endTime: _endDate.toString(),
                                                  gender: gender,
                                                  interest: interest,
                                                  imageName: imageName,
                                                  file: _image,
                                                  opportunityId: widget
                                                      .oppertunityModel!.id!,
                                                );
                                              }
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 98,
                                          decoration: BoxDecoration(
                                            color: ColorClass.darkGreenColor,
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'حفظ',
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
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
      ),
    );
  }
}
