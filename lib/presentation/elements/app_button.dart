import 'package:flutter/material.dart';

import '../../configuration/front_end.dart';
import 'custom_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.height,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 21,
    this.fontFamily = 'Roboto',
  }) : super(key: key);
  final String text;
  final double height;
  final VoidCallback onPressed;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: FrontEndConfigs.kPrimaryColor,
          onPressed: onPressed,
          child: CustomText(
              text: text,
              fontSize: fontSize!,
              fontFamily: fontFamily,
              textColor: FrontEndConfigs.kWhiteColor,
              fontWeight: fontWeight!)),
    );
  }
}
