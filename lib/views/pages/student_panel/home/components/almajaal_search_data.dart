import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:tatwei/controllers/student_controller.dart';
import 'package:tatwei/model/search_model.dart';

class AlmajaalSearchData extends StatefulWidget {
  const AlmajaalSearchData({
    super.key,
  });

  @override
  State<AlmajaalSearchData> createState() => _AlmajaalSearchDataState();
}

class _AlmajaalSearchDataState extends State<AlmajaalSearchData> {
  StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      width: Get.width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (almajaalList.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          int startIndex = rowIndex * 2;
          int endIndex = (rowIndex + 1) * 2;

          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                endIndex - startIndex,
                (index) {
                  int itemIndex = startIndex + index;
                  if (itemIndex < almajaalList.length) {
                    return SizedBox(
                      width: Get.width * 0.3,
                      child: Row(
                        children: [
                          MSHCheckbox(
                            size: 20,
                            value: almajaalList[itemIndex].checkValue,
                            colorConfig:
                                MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Colors.black,
                              uncheckedColor: Colors.black,
                            ),
                            style: MSHCheckboxStyle.stroke,
                            onChanged: (selected) {
                              setState(() {
                                almajaalList[itemIndex].checkValue = selected;
                                if (selected) {
                                  studentController.interestList
                                      .add(almajaalList[itemIndex].title);

                                  print(
                                      'interest list length is ${studentController.interestList.length}');
                                } else {
                                  studentController.interestList.removeWhere(
                                      (element) =>
                                          element ==
                                          almajaalList[itemIndex].title);
                                  print(
                                      'interest list length is ${studentController.interestList.length}');
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            almajaalList[itemIndex].title,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: Get.width * 0.2),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: const Color(0xff7EB347).withOpacity(.38),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            title,
            style: GoogleFonts.inter(color: Colors.black, fontSize: 32),
          ),
        ),
      ),
    );
  }
}
