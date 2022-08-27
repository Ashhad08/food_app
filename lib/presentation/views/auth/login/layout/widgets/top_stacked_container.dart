import 'package:flutter/material.dart';

import '../../../../../elements/custom_text.dart';

class TopStackedContainer extends StatelessWidget {
  const TopStackedContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              top: 60,
              left: -30,
              child: Image.asset(
                'assets/images/login_support_1.png',
                height: 77,
                width: 82,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 140,
              left: -10,
              child: Image.asset(
                'assets/images/login_support_2.png',
                height: 69,
                width: 94,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 60,
              right: -30,
              child: Image.asset(
                'assets/images/login_support_3.png',
                height: 82,
                width: 118,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 140,
              right: -15,
              child: Image.asset(
                'assets/images/login_support_4.png',
                height: 82,
                width: 70,
                fit: BoxFit.cover,
              )),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 73,
                    width: 143,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                      text: 'Dynamic Data Development',
                      fontSize: 14,
                      fontWeight: FontWeight.w500)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
