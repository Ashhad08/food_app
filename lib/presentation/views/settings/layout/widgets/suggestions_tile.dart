import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';
import '../../../../elements/custom_text.dart';

class SuggestionsTile extends StatelessWidget {
  const SuggestionsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: FrontEndConfigs.kWhiteColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTile('Share the app'),
            buildDivider(),
            buildTile('Rate our app'),
            buildDivider(),
            buildTile('Contact us'),
            buildDivider(),
            buildTile('About us'),
          ],
        ));
  }

  Widget buildTile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomText(
          text: title,
          fontSize: 12,
          align: TextAlign.start,
          textColor: FrontEndConfigs.kSubTextColor,
          fontWeight: FontWeight.w400),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0,
      thickness: 0.5,
      color: Color(0xffC7C7C7),
    );
  }
}
