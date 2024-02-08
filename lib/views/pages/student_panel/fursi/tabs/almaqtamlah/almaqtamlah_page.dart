import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/model/oppertunity_model.dart';

class AlmaqtamlahPage extends StatefulWidget {
  const AlmaqtamlahPage({super.key});

  @override
  State<AlmaqtamlahPage> createState() => _AlmaqtamlahPageState();
}

class _AlmaqtamlahPageState extends State<AlmaqtamlahPage> {
  bool isShowPopUP = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: oppeertunityList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorClass.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(oppeertunityList[index].image),
                          const SizedBox(width: 5),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // width: Get.width * 0.6,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 0),
                                      decoration: BoxDecoration(
                                        color: ColorClass.darkGreenColor
                                            .withOpacity(.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        oppeertunityList[index].title,
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
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
                                                isShowPopUP = true;
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 103,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: const Color(0xff7EB347)
                                                      .withOpacity(.38)),
                                              child: Center(
                                                child: Text(
                                                  'رفع الشهادة',
                                                  style: GoogleFonts.inter(
                                                      color: Colors.black,
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 92,
                            decoration: BoxDecoration(
                              color: ColorClass.darkGreenColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Image.asset('assets/icons/text.png')),
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowPopUP = false;
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
                                  child: Image.asset('assets/icons/حفظ.png')),
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
