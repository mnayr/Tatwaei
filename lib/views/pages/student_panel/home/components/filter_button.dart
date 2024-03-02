import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatwei/controllers/admin_controller.dart';
import 'package:tatwei/controllers/school_controller.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/views/pages/student_panel/home/components/aljins_search_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/almajaal_search_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/almakaan_search_data.dart';
import 'package:tatwei/views/pages/student_panel/home/components/apply_filter_button.dart';

class FilterButton extends StatelessWidget {
  FilterButton({
    super.key,
  });

  final StudentController studentController = Get.put(StudentController());
  final SchoolController schoolController = Get.put(SchoolController());
  final AdminController adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AwesomeDialog(
            dismissOnTouchOutside: false,
            width: Get.width,
            dialogBackgroundColor: const Color(0xffF5F0A9).withOpacity(.8),
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            body: StatefulBuilder(
              builder: (context, setState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchHeader(title: 'المجال'),
                  const AlmajaalSearchData(),
                  const SearchHeader(title: 'المكان'),
                  const AlmakaanSearchData(),
                  const SearchHeader(title: 'الجنس'),
                  const AlJinsSearchData(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ApplyFilterButton(
                        onTap: () {
                          studentController.getFilterOppertunities();
                          Get.back();
                        },
                        title: 'اغلاق',
                      ),
                      ApplyFilterButton(
                        onTap: () {
                          studentController.getOppertunities();
                          schoolController.getOppertunities();
                          adminController.getOppertunities();
                          Get.back();
                        },
                        title: 'تطبيق',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ).show();
        },
        child: SvgPicture.asset('assets/icons/filter.svg'));
  }
}
