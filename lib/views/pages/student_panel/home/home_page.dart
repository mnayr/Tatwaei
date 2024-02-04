import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/model/oppertunity_model.dart';
import 'package:tatwei/model/search_model.dart';
import 'package:tatwei/views/pages/student_panel/components/drawer_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/aljins_search_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/almajaal_search_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/almakaan_search_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';
import 'package:tatwei/views/pages/student_panel/home/components/filter_button.dart';
import 'package:tatwei/views/pages/student_panel/home/components/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerData(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
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
              child: ListView.builder(
                itemCount: oppeertunityList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                                  children: [
                                    Container(
                                      width: Get.width * 0.6,
                                      padding: const EdgeInsets.all(10),
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
        ),
      ),
    );
  }
}