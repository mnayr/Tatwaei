import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';

class AlhaaliaPage extends StatelessWidget {
  const AlhaaliaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: oppeertunityList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // width: Get.width * 0.6,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
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
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ApplyFilterButton(
                                          title: 'خدمية', onTap: () {}),
                                      ApplyFilterButton(
                                          title: 'داخلية', onTap: () {}),
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
    );
  }
}
