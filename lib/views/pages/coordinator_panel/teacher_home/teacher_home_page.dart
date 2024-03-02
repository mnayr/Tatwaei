import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/views/pages/coordinator_panel/components/teacher_drawer_data.dart';
import 'package:tatwei/views/pages/coordinator_panel/teacher_home/oppertunity_detail_page.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';
import 'package:tatwei/views/pages/student_panel/home/components/filter_button.dart';
import 'package:tatwei/views/pages/student_panel/home/components/search_field.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  bool isChecked = false;

  SchoolController schoolController = Get.put(SchoolController());

  @override
  void initState() {
    schoolController.getSchoolInformation();
    schoolController.getOppertunities();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: TeacherDrawerData(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 40,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
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
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      textDirection: TextDirection.rtl,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('assets/icons/search.svg'),
                        ),
                        filled: true,
                        fillColor: const Color(0xffD3CA25).withOpacity(.1),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color(0xffD3CA25).withOpacity(.1),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color(0xffD3CA25).withOpacity(.1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color(0xffD3CA25).withOpacity(.1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color(0xffD3CA25).withOpacity(.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilterButton(),
                ],
              ),
            ),

            // const SearchField(),
            SizedBox(height: Get.height * 0.03),
            Expanded(
              child: GetX<SchoolController>(
                  init: Get.put(SchoolController()),
                  builder: (cont) {
                    return ListView.builder(
                      itemCount: cont.getOpportunityListList.length,
                      itemBuilder: (context, index) {
                        OppertunityModel oppertunityModel =
                            cont.getOpportunityListList[index];
                        return cont
                                .getOpportunityListList[index].oppertunityName!
                                .contains(searchController.text)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    // Get.to(() => const TeacherHomeDetailPage());

                                    Get.to(() => TeacherOppertunityDetailPage(
                                          oppertunityModel: oppertunityModel,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorClass.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              oppertunityModel.imageUrl!),
                                        ),
                                        // Image.network(oppertunityModel.imageUrl!),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
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
                                                    child: Center(
                                                      child: Text(
                                                        oppertunityModel
                                                            .oppertunityName!,
                                                        style: GoogleFonts.inter(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.02),
                                                  SizedBox(
                                                    width: Get.width * 0.6,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ApplyFilterButton(
                                                            title:
                                                                oppertunityModel
                                                                    .interest!,
                                                            onTap: () {}),
                                                        SizedBox(
                                                            width: Get.width *
                                                                0.02),
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
                              )
                            : SizedBox();
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
