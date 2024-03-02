import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/model/student_model.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  SchoolController schoolController = Get.put(SchoolController());

  @override
  void initState() {
    schoolController.getUnverifiedStudents();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/logo_text.png'),
          )
        ],
        backgroundColor: const Color(0xffD3CA25).withOpacity(.3),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icons/request.png'),
        ),
        title: Text(
          'توثيق الطلاب ',
          style: FontStyles.boldText,
        ),
      ),
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
              SizedBox(height: Get.height * 0.02),
              GetX<SchoolController>(
                  init: schoolController,
                  builder: (cont) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: cont.getunverifiedStudentsList.length,
                        itemBuilder: (context, index) {
                          StudentModel studentModel =
                              cont.getunverifiedStudentsList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorClass.primaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          // width: Get.width * 0.6,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          decoration: BoxDecoration(
                                            color: ColorClass.darkGreenColor
                                                .withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              studentModel.studenName!,
                                              style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    SizedBox(
                                      width: Get.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // width: Get.width * 0.6,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: ColorClass.darkGreenColor
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                studentModel.studentGrade!,
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              cont.declinetRequest(
                                                  studentModel.studentId!);
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 76,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color:
                                                      const Color(0xffA90505)),
                                              child: Center(
                                                child: Text(
                                                  'رفض',
                                                  style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          GestureDetector(
                                            onTap: () {
                                              cont.acceptRequest(
                                                  studentModel.studentId!);
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 76,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: ColorClass
                                                      .darkGreenColor),
                                              child: Center(
                                                child: Text(
                                                  'قبول',
                                                  style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
