import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';
import '../../../../elements/custom_text.dart';
import '../../../favourite_items/favourite_items_view.dart';

class NotificationCards extends StatefulWidget {
  const NotificationCards({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationCards> createState() => _NotificationCardsState();
}

class _NotificationCardsState extends State<NotificationCards> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          width: double.infinity,
          decoration: BoxDecoration(
            color: FrontEndConfigs.kWhiteColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Push Notifications',
                fontSize: 12,
                align: TextAlign.start,
                fontWeight: FontWeight.w400,
                textColor: FrontEndConfigs.kSubTextColor,
              ),
              SizedBox(
                height: 20,
                child: CupertinoSwitch(
                    value: switchValue,
                    onChanged: (val) {
                      setState(() {
                        switchValue = val;
                      });
                    }),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FrontEndConfigs.kWhiteColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouriteItemsView()));
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CustomText(
                    text: 'My Favourite Food',
                    fontSize: 12,
                    align: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    textColor: FrontEndConfigs.kSubTextColor,
                  ),
                  Icon(
                    Icons.favorite,
                    color: FrontEndConfigs.kPrimaryColor,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
