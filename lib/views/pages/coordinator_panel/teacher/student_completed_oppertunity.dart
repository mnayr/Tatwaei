import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/model/registered_and_completed_oppertunitymode;.dart';
import 'package:tatwei/model/student_model.dart';

class StudentCompletedOpportunity extends StatefulWidget {
  const StudentCompletedOpportunity({super.key, required this.studentModel});
  final StudentModel studentModel;
  @override
  State<StudentCompletedOpportunity> createState() => _AlmaqtamlahPageState();
}

class _AlmaqtamlahPageState extends State<StudentCompletedOpportunity> {
  bool isShowPopUP = false;

  SchoolController schoolController = Get.put(SchoolController());
  RegisteredAndCompletedOppertunityModel?
      registeredAndCompletedOppertunityModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Expanded(
              child: GetX<SchoolController>(
                  init: Get.put(SchoolController()),
                  builder: (cont) {
                    return ListView.builder(
                      itemCount: cont.getcompletedOpportunityList.length,
                      itemBuilder: (context, index) {
                        RegisteredAndCompletedOppertunityModel
                            oppertunityModel =
                            cont.getcompletedOpportunityList[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: ColorClass.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  oppertunityModel.imageUrl.value.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              oppertunityModel.imageUrl.value),
                                        ),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // width: Get.width * 0.6,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 0),
                                              decoration: BoxDecoration(
                                                color: ColorClass.darkGreenColor
                                                    .withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                            SizedBox(height: Get.height * 0.02),
                                            SizedBox(
                                              width: Get.width * 0.6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        registeredAndCompletedOppertunityModel =
                                                            oppertunityModel;

                                                        isShowPopUP = true;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 103,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: const Color(
                                                                  0xff7EB347)
                                                              .withOpacity(
                                                                  .38)),
                                                      child: Center(
                                                        child: Text(
                                                          'عرض الشهادة',
                                                          style: GoogleFonts.inter(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
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
                                    ],
                                  ),
                                ],
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 186,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: registeredAndCompletedOppertunityModel!
                                .certificatImage!,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                schoolController.acceptCertificate(
                                    widget.studentModel,
                                    registeredAndCompletedOppertunityModel!);

                                isShowPopUP = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 92,
                              decoration: BoxDecoration(
                                color: ColorClass.darkGreenColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Text(
                                'توثيق',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowPopUP = !isShowPopUP;

                                // if (imageFile != null) {
                                //   studentController
                                //       .uploadCertificate(
                                //           imageFile!,
                                //           registeredAndCompletedOppertunityModel!
                                //               .id!)
                                //       .then((value) {
                                //     isShowPopUP = false;
                                //   });
                                // } else {
                                //   isShowPopUP = false;
                                // }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 92,
                              decoration: BoxDecoration(
                                color: ColorClass.darkGreenColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                  child: Text(
                                'رفض',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
