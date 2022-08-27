import 'package:flutter/material.dart';
import 'package:food_app/backend/models/user.dart';
import 'package:food_app/backend/services/system.dart';
import 'package:provider/provider.dart';

import '../../../../configuration/front_end.dart';
import '../../../elements/custom_text.dart';
import 'widgets/notification_cards.dart';
import 'widgets/suggestions_tile.dart';
import 'widgets/warning_days_selection_tile.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({Key? key}) : super(key: key);

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  @override
  Widget build(BuildContext context) {
    SystemServices systemServices = SystemServices();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Settings',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                textColor: FrontEndConfigs.kPrimaryColor,
              ),
              const CustomText(
                text: 'Manage your app settings from here',
                fontSize: 14,
                align: TextAlign.start,
                fontWeight: FontWeight.w500,
                textColor: Color(0xff8D8D8D),
              ),
              const SizedBox(
                height: 18,
              ),
              const CustomText(
                text: 'My Account',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: FrontEndConfigs.kSubTextColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FrontEndConfigs.kWhiteColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: StreamProvider.value(
                  value: systemServices.fetchCurrentUserName(),
                  initialData: UserModel(),
                  builder: (context, child) {
                    UserModel model = context.watch<UserModel>();
                    return CustomText(
                      text: model.name.toString(),
                      fontSize: 12,
                      align: TextAlign.start,
                      fontWeight: FontWeight.w400,
                      textColor: FrontEndConfigs.kSubTextColor,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                text: 'Notifications',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: FrontEndConfigs.kSubTextColor,
              ),
              const SizedBox(
                height: 10,
              ),
              const NotificationCards(),
              const SizedBox(
                height: 5,
              ),
              const CustomText(
                text: 'Be warn how many days before?',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: FrontEndConfigs.kSubTextColor,
              ),
              const SizedBox(
                height: 10,
              ),
              const WarningDaysSelectionTile(),
              const SizedBox(
                height: 30,
              ),
              const CustomText(
                text: 'Do you Like our app?',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: FrontEndConfigs.kSubTextColor,
              ),
              const SizedBox(
                height: 18,
              ),
              const SuggestionsTile(),
              const SizedBox(
                height: 14,
              ),
              const Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'Application version 1.324',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: FrontEndConfigs.kSubTextColor,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
