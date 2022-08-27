import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';

class CustomDropDownTile extends StatelessWidget {
  const CustomDropDownTile({
    Key? key,
    required this.itemValue,
    required this.itemsList,
    this.onChange,
  }) : super(key: key);
  final String itemValue;
  final List<String> itemsList;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        elevation: 3,
        dropdownColor: FrontEndConfigs.kWhiteColor,
        isExpanded: true,
        value: itemValue,
        style: FrontEndConfigs.kTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: const Color(0xff414141)),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 20,
          color: Color(0xff9B9B9B),
        ),
        onChanged: (String? newValue) => onChange!(newValue!),
        items: itemsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
