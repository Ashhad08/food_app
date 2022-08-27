import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';
import '../../../../elements/custom_text.dart';

class GroceryListItemsTile extends StatelessWidget {
  const GroceryListItemsTile({
    Key? key,
    required this.groceryItemName,
    required this.onPressed,
  }) : super(key: key);
  final String groceryItemName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              CustomText(
                  text: groceryItemName,
                  fontSize: 14,
                  textColor: const Color(0xff8D8D8D),
                  fontWeight: FontWeight.w500),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: FrontEndConfigs.kSubTextColor,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
            color: Color(0xffD9D9D9),
          )
        ],
      ),
    );
  }
}
