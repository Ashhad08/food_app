import 'package:flutter/material.dart';

import '../../configuration/front_end.dart';

class ItemsSearchField extends StatelessWidget {
  const ItemsSearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        style: FrontEndConfigs.kTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xffA7A7A7)),
        decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: const Color(0xffF0F0F0),
            contentPadding: const EdgeInsets.only(top: 10),
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 20,
              color: Color(0xff898989),
            ),
            suffixIcon: const Icon(
              Icons.menu,
              size: 20,
              color: Color(0xff898989),
            ),
            hintText: 'Search here',
            hintStyle: FrontEndConfigs.kTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xffA7A7A7))),
      ),
    );
  }
}
