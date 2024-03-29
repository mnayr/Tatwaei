import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/model/registered_and_completed_oppertunitymode;.dart';

class AlmaqtamlahPage extends StatefulWidget {
  const AlmaqtamlahPage({super.key});

  @override
  State<AlmaqtamlahPage> createState() => _AlmaqtamlahPageState();
}

class _AlmaqtamlahPageState extends State<AlmaqtamlahPage> {
  bool isShowPopUP = false;

  File? imageFile;

  chooseProfilePic(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage == null) return null;
      File img = File(pickedImage.path);
      setState(() {
        imageFile = img;
      });

      return img;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  StudentController studentController = Get.put(StudentController());
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
              child: GetX<StudentController>(
                  init: Get.put(StudentController()),
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
                                                          'رفع الشهادة',
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
                        child: registeredAndCompletedOppertunityModel!
                                .certificatImage!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    registeredAndCompletedOppertunityModel!
                                        .certificatImage!,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            : imageFile != null
                                ? Image.file(imageFile!)
                                : Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        chooseProfilePic(ImageSource.gallery);
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 92,
                                          decoration: BoxDecoration(
                                            color: ColorClass.darkGreenColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                              child: Image.asset(
                                                  'assets/icons/text.png'))),
                                    ),
                                  ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowPopUP = false;
                                imageFile = null;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 92,
                              decoration: BoxDecoration(
                                color: ColorClass.darkGreenColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Image.asset('assets/icons/الغاء.png'),
                            ),
                          ),
                          Obx(
                            () => studentController.isCertificateUpload.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (imageFile != null) {
                                          studentController
                                              .uploadCertificate(
                                                  imageFile!,
                                                  registeredAndCompletedOppertunityModel!
                                                      .id!)
                                              .then((value) {
                                            isShowPopUP = false;
                                          });
                                        } else {
                                          isShowPopUP = false;
                                        }
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
                                          child: Image.asset(
                                              'assets/icons/حفظ.png')),
                                    ),
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
