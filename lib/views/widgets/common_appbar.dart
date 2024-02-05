import 'package:flutter/material.dart';
import 'package:tatwei/constants/font_style.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final String title;
  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icons/logo_text.png'),
        )
      ],
      backgroundColor: const Color(0xffD3CA25).withOpacity(.3),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/icons/profile.png'),
      ),
      title: Text(
        title,
        style: FontStyles.boldText,
      ),
    );
  }
}
