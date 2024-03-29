import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/admin_controller.dart';
import 'package:tatwei/model/dymmy_oppertunity_model.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/views/pages/admin_panel/admin_home/admin_edit_home_detail_page.dart';
import 'package:tatwei/views/pages/admin_panel/admin_home/admin_home_detail_page.dart';
import 'package:tatwei/views/pages/admin_panel/components/admin_drawer_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';
import 'package:tatwei/views/pages/student_panel/home/components/search_field.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool isChecked = false;
  AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    adminController.getAdminInformation().then((value) {
      adminController.getOppertunities();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AdminDrawerData(),
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
            const SearchField(),
            SizedBox(height: Get.height * 0.03),

            Expanded(
              child: GetX<AdminController>(
                  init: Get.put(AdminController()),
                  builder: (cont) {
                    return ListView.builder(
                      itemCount: cont.getOpportunityListList.length,
                      itemBuilder: (context, index) {
                        OppertunityModel oppertunityModel =
                            cont.getOpportunityListList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => AdminEditHomeDetailPage(
                                    oppertunityModel:
                                        cont.getOpportunityListList[index],
                                  ));

                              // Get.to(() => const TeacherHomeDetailPage());

                              // Get.to(() => TeacherOppertunityDetailPage(
                              //       oppertunityModel: oppertunityModel,
                              //     ));
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
                                        padding: const EdgeInsets.all(8.0),
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
                                              child: Center(
                                                child: Text(
                                                  oppertunityModel
                                                      .oppertunityName!,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
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
                                                          .interest!,
                                                      onTap: () {}),
                                                  SizedBox(
                                                      width: Get.width * 0.02),
                                                  ApplyFilterButton(
                                                      title: oppertunityModel
                                                              .isExternal!
                                                          ? 'خارجية '
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

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: oppeertunityList.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            //         child: GestureDetector(
            //           onTap: () {
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: ColorClass.primaryColor,
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //             child: Row(
            //               children: [
            //                 Image.asset(oppeertunityList[index].image),
            //                 Column(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Container(
            //                             // width: Get.width * 0.6,
            //                             padding: const EdgeInsets.symmetric(
            //                                 horizontal: 15, vertical: 0),
            //                             decoration: BoxDecoration(
            //                               color: ColorClass.darkGreenColor
            //                                   .withOpacity(.5),
            //                               borderRadius:
            //                                   BorderRadius.circular(10),
            //                             ),
            //                             child: Text(
            //                               oppeertunityList[index].title,
            //                               style: GoogleFonts.inter(
            //                                   fontSize: 18,
            //                                   fontWeight: FontWeight.normal),
            //                             ),
            //                           ),
            //                           SizedBox(height: Get.height * 0.02),
            //                           SizedBox(
            //                             width: Get.width * 0.6,
            //                             child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.start,
            //                               children: [
            //                                 ApplyFilterButton(
            //                                     title: 'خدمية', onTap: () {}),
            //                                 SizedBox(width: Get.width * 0.02),
            //                                 ApplyFilterButton(
            //                                     title: 'داخلية',
            //                                     onTap: () => Get.to(() =>
            //                                         const AdminHomeDetailPage())),
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
