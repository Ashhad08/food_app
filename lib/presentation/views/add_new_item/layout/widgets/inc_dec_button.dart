import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';

class IncDecButton extends StatelessWidget {
  const IncDecButton({Key? key, required this.onPressed, required this.icon}) : super(key: key);
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 35,
        width: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: FrontEndConfigs.kPrimaryColor),
        child: Icon(
          icon,
          color: FrontEndConfigs.kWhiteColor,
        ),
      ),
    );
  }
}

