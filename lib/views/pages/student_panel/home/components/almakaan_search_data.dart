import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/model/search_model.dart';

class AlmakaanSearchData extends StatefulWidget {
  const AlmakaanSearchData({
    super.key,
  });

  @override
  State<AlmakaanSearchData> createState() => _AlmakaanSearchDataState();
}

class _AlmakaanSearchDataState extends State<AlmakaanSearchData> {
  StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.15,
      width: Get.width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: almakaanList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    MSHCheckbox(
                      size: 20,
                      value: almakaanList[index].checkValue,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.black,
                        uncheckedColor: Colors.black,
                      ),
                      style: MSHCheckboxStyle.stroke,
                      onChanged: (selected) {
                        setState(() {
                          almakaanList[index].checkValue = true;
                          if (index == 0) {
                            almakaanList[index].checkValue = true;
                            almakaanList[1].checkValue = false;
                            studentController.isExternal = false;
                          } else {
                            studentController.isExternal = true;

                            almakaanList[index].checkValue = true;
                            almakaanList[0].checkValue = false;
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      almakaanList[index].title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
