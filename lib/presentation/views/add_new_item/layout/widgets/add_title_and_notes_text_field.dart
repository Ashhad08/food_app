import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';

class ItemTitleAndNotesTextField extends StatelessWidget {
  const ItemTitleAndNotesTextField({
    Key? key,
    required this.hintText,
    required this.maxLines,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        style: FrontEndConfigs.kTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: const Color(0xff414141)),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 10),
            hintText: hintText,
            hintStyle: FrontEndConfigs.kTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color(0xff414141))),
      ),
    );
  }
}
