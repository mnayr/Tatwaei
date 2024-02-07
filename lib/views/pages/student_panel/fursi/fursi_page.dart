import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/views/pages/student_panel/fursi/tabs/alhaalia/alhaalia_page.dart';
import 'package:tatwei/views/pages/student_panel/fursi/tabs/almaqtamlah/almaqtamlah_page.dart';

class FursiPage extends StatefulWidget {
  const FursiPage({super.key});

  @override
  State<FursiPage> createState() => _FursiPageState();
}

class _FursiPageState extends State<FursiPage> {
  int selectedIndex = 0;
  final _tabBar = [
    AlhaaliaPage(),
    AlmaqtamlahPage(),
  ];
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
                'assets/icons/fursi.png',
                // fit: BoxFit.cover,
              ),
            );
          }),
          title: Text(
            'فرصي',
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
              GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset('assets/icons/back_arrow.svg')),
              SizedBox(height: Get.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  tab('الحالية', 0),
                  tab('المكتملة', 1),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(child: _tabBar[selectedIndex]),
            ],
          ),
        ),
      ),
    );
  }

  Widget tab(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 35,
        width: 116,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == selectedIndex
              ? ColorClass.darkGreenColor.withOpacity(.4)
              : ColorClass.primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.inter(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
