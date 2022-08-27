import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';
import '../../../../elements/custom_text.dart';

class MyPopUpButton extends StatelessWidget {
  const MyPopUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        splashRadius: 20,
        icon: const Icon(
          Icons.more_vert_rounded,
          size: 23,
          color: FrontEndConfigs.kBlackColor,
        ),
        itemBuilder: (context) => [
              const PopupMenuItem(
                  child: CustomText(
                      text: 'Share list',
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              const PopupMenuItem(
                  child: CustomText(
                      text: 'Invite Friend',
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              const PopupMenuItem(
                  child: CustomText(
                      text: 'My list',
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ]);
  }
}
