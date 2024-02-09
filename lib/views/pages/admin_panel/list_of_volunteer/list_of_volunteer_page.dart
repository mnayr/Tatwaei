import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/views/pages/admin_panel/list_of_volunteer/add_oppertunity_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/teacher_home/teacher_home_detail_page.dart';
import 'package:tatwei/views/pages/coordinator_panel/teacher_home/teacher_home_page.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';

class ListofVolunteerPage extends StatelessWidget {
  const ListofVolunteerPage({super.key});

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
            'فرص التطوع',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset('assets/icons/back_arrow.svg')),
                  GestureDetector(
                    onTap: () => Get.to(() => AddOppertunityPage()),
                    child: Container(
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorClass.darkGreenColor),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: ColorClass.darkGreenColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: ListView.builder(
                  itemCount: oppeertunityList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Get.off(() => const TeacherHomeDetailPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorClass.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(oppeertunityList[index].image),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                                MainAxisAlignment.start,
                                            children: [
                                              ApplyFilterButton(
                                                  title: 'خدمية', onTap: () {}),
                                              SizedBox(width: Get.width * 0.02),
                                              ApplyFilterButton(
                                                  title: 'داخلية',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
