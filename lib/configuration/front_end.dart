import 'package:flutter/material.dart';

class FrontEndConfigs {
  static const Color kPrimaryColor = Color(0xff3AAA35);
  static const Color kBlackColor = Color(0xff464545);
  static const Color kSubTextColor = Color(0xff696969);
  static const Color kWhiteColor = Colors.white;
  static const TextStyle kTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: Color(0xff363636));
  static Widget kAppbarLogo = Image.asset(
    'assets/images/logo.png',
    height: 34,
    width: 67,
    //fit: BoxFit.cover,
  );
}
