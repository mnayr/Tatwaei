// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    this.isShowPrefix = true,
    this.isBoldTitle = false,
    this.isFilled = false,
  });
  final TextEditingController controller;
  final String prefixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  bool isObscure;
  final String title;
  bool isShowPrefix;
  bool isBoldTitle;
  bool isFilled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: isBoldTitle
                ? GoogleFonts.inter(color: Colors.black, fontSize: 17)
                : FontStyles.textFieldText),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: isObscure,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            filled: isFilled,
            fillColor: isFilled ? ColorClass.primaryColor : null,
            hintTextDirection: TextDirection.rtl,
            suffixIcon: isShowPrefix ? Image.asset(prefixIcon) : null,
            contentPadding: const EdgeInsets.only(right: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
                color: isFilled
                    ? ColorClass.primaryColor
                    : ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
                color: isFilled
                    ? ColorClass.primaryColor
                    : ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
                color: isFilled
                    ? ColorClass.primaryColor
                    : ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
                color: isFilled
                    ? ColorClass.primaryColor
                    : ColorClass.darkGreenColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
