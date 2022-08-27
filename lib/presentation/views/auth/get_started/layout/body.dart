import 'package:flutter/material.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/elements/custom_text.dart';

import '../../../../elements/app_button.dart';
import '../../login/login_view.dart';

class GetStartedViewBody extends StatelessWidget {
  const GetStartedViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FrontEndConfigs.kWhiteColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 139,
                  width: 269,
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/food_basket.png',
                  width: 277.21,
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomText(
                  text: 'Food Care',
                  fontFamily: 'Roboto',
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  textColor: FrontEndConfigs.kPrimaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 28, top: 10),
                  child: CustomText(
                    text:
                        'Without health, Life is almost dead! A healthy Food holds a Healthy Soul & mind!',
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    textColor: FrontEndConfigs.kBlackColor.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 46),
                  child: AppButton(
                    text: 'Get Started Now',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    },
                    height: 77,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
