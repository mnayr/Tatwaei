import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/model/registered_and_completed_oppertunitymode;.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';

class StudentRegisteredOpportunity extends StatelessWidget {
  const StudentRegisteredOpportunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GetX<SchoolController>(
              init: Get.put(SchoolController()),
              builder: (cont) {
                return ListView.builder(
                  itemCount: cont.getregisteredOpportunityListList.length,
                  itemBuilder: (context, index) {
                    RegisteredAndCompletedOppertunityModel oppertunityModel =
                        cont.getregisteredOpportunityListList[index];
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
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
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        SizedBox(
                                          width: Get.width * 0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ApplyFilterButton(
                                                  title: oppertunityModel
                                                      .interest.value,
                                                  onTap: () {}),
                                              SizedBox(width: Get.width * 0.02),
                                              ApplyFilterButton(
                                                  title: oppertunityModel
                                                          .isExternal.value
                                                      ? 'داخلية'
                                                      : 'داخلية',
                                                  onTap: () {}),
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
    );
  }
}
