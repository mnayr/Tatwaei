// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tatwei/constants/colors.dart';
import 'package:tatwei/constants/font_style.dart';

class CommonField extends StatelessWidget {
  CommonField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.onChanged,
    required this.validator,
    this.isObscure = false,
    required this.title,
  });
  final TextEditingController controller;
  final String prefixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  bool isObscure;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FontStyles.textFieldText),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: isObscure,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            suffixIcon: Image.asset(prefixIcon),
            contentPadding: const EdgeInsets.only(right: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
