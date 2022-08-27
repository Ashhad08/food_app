import 'package:flutter/material.dart';

import '../../configuration/front_end.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final Color? textColor;
  final TextAlign? align;
  final int? maxLines;

  const CustomText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.textColor = FrontEndConfigs.kBlackColor,
    this.align = TextAlign.center,
    this.fontFamily = 'Poppins',
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor),
      textAlign: align,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
