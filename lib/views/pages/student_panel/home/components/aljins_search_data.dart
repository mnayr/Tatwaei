import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:tatwei/model/search_model.dart';

class AlJinsSearchData extends StatefulWidget {
  const AlJinsSearchData({
    super.key,
  });

  @override
  State<AlJinsSearchData> createState() => _AlJinsSearchDataState();
}

class _AlJinsSearchDataState extends State<AlJinsSearchData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.15,
      width: Get.width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: aljinsList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    MSHCheckbox(
                      size: 20,
                      value: aljinsList[index].checkValue,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.black,
                        uncheckedColor: Colors.black,
                      ),
                      style: MSHCheckboxStyle.stroke,
                      onChanged: (selected) {
                        setState(() {
                          aljinsList[index].checkValue = selected;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      aljinsList[index].title,
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
