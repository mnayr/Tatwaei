// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/controllers/admin_controller.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    super.key,
    required this.instituteOption,
  });

  final List<String> instituteOption;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
        init: Get.put(AdminController()),
        builder: (cont) {
          return Container(
            height: Get.height * 0.06,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: ColorClass.darkGreenColor, width: 2),
                borderRadius: BorderRadius.circular(9)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(9),
                  isExpanded: true,
                  hint: const Text('---------------'),
                  value: cont.selectedGrade,
                  onChanged: (newValue) {
                    setState(() {
                      cont.selectedGrade = newValue;
                    });
                  },
                  items: widget.instituteOption.map((ins) {
                    return DropdownMenuItem(
                      value: ins,
                      child: Text(ins),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }
}
