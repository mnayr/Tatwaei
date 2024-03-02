import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/model/registered_and_completed_oppertunitymode;.dart';

class SaatiPage extends StatefulWidget {
  const SaatiPage({super.key});

  @override
  State<SaatiPage> createState() => _SaatiPageState();
}

class _SaatiPageState extends State<SaatiPage> {
  bool isShowPopUP = false;
  StudentController studentController = Get.put(StudentController());
  @override
  void initState() {
    studentController.getALLVerifiedOpportunityList();
    // TODO: implement initState
    super.initState();
  }

  double calculateWorkingHoursPercentage() {
    double percentage = studentController.getstudentData.totalHours! / 40;

    print('percentage is $percentage');

    return percentage;
  }

  RegisteredAndCompletedOppertunityModel?
      registeredAndCompletedOppertunityModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/icons/clock.png',
              ),
            );
          }),
          title: Text(
            'ساعاتي',
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset('assets/icons/back_arrow.svg')),
                  SizedBox(height: Get.height * 0.03),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xff7EB347).withOpacity(.38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'الساعات التي تم اكتمالها',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  GetX<StudentController>(
                      init: studentController,
                      builder: (cont) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ColorClass.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7EB347)
                                          .withOpacity(.38),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${studentController.getstudentData.totalHours} ساعه',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(12),
                                  minHeight: 30,
                                  value: calculateWorkingHoursPercentage(),
                                  backgroundColor: Colors.white,
                                  color: ColorClass.darkGreenColor),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xff7EB347).withOpacity(.38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'فرص تطوع تم التحقق منها ',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Expanded(
                    child: GetX<StudentController>(
                        init: studentController,
                        builder: (cont) {
                          return ListView.builder(
                            itemCount: cont.getVerifiedOpportunityList.length,
                            itemBuilder: (context, index) {
                              RegisteredAndCompletedOppertunityModel
                                  oppertunityModel =
                                  cont.getVerifiedOpportunityList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorClass.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          oppertunityModel
                                                  .imageUrl.value.isEmpty
                                              ? CircleAvatar(
                                                  radius: 25,
                                                )
                                              : CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      oppertunityModel
                                                          .imageUrl.value),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // width: Get.width * 0.6,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 0),
                                                  decoration: BoxDecoration(
                                                    color: ColorClass
                                                        .darkGreenColor
                                                        .withOpacity(.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    oppertunityModel
                                                        .oppertunityName.value,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: Get.height * 0.02),
                                                SizedBox(
                                                  width: Get.width * 0.67,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isShowPopUP = true;
                                                            registeredAndCompletedOppertunityModel =
                                                                oppertunityModel;
                                                            print(
                                                                'value$isShowPopUP');
                                                          });
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorClass
                                                                .darkGreenColor
                                                                .withOpacity(
                                                                    .5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .remove_red_eye,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              Text(
                                                                'عرض الشهادة',
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
              isShowPopUP
                  ? Container(
                      height: 281,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xffeeecb2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isShowPopUP = false;
                                  });
                                },
                                child:
                                    Image.asset('assets/icons/x-circle.png')),
                            SizedBox(height: Get.height * 0.02),
                            Center(
                                child: CachedNetworkImage(
                              imageUrl: registeredAndCompletedOppertunityModel!
                                  .imageUrl.value,
                              placeholder: (context, value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            )),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
