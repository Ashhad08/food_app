import 'package:flutter/material.dart';

import '../../../../../configuration/front_end.dart';
import '../../../../elements/custom_text.dart';

class WarningDaysSelectionTile extends StatefulWidget {
  const WarningDaysSelectionTile({
    Key? key,
  }) : super(key: key);

  @override
  State<WarningDaysSelectionTile> createState() =>
      _WarningDaysSelectionTileState();
}

class _WarningDaysSelectionTileState extends State<WarningDaysSelectionTile> {
  String _initialValue = '1d';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: FrontEndConfigs.kWhiteColor,
      ),
      child: Container(
        height: 37,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5, bottom: 3, left: 15, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: FrontEndConfigs.kPrimaryColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSelectedDaysCard(
              '1d',
            ),
            _buildVerticalDivider(),
            _buildSelectedDaysCard('2d'),
            _buildVerticalDivider(),
            _buildSelectedDaysCard('3d'),
            _buildVerticalDivider(),
            _buildSelectedDaysCard('4d'),
            _buildVerticalDivider(),
            _buildSelectedDaysCard('5d'),
            _buildVerticalDivider(),
            _buildSelectedDaysCard('6d'),
            _buildVerticalDivider(),
            _buildSelectedDaysCard('7d'),
            _buildVerticalDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 15,
      width: 1,
      color: const Color(0xff343131),
    );
  }

  Widget _buildSelectedDaysCard(String days) {
    return GestureDetector(
        onTap: () {
          onTapped(days);
        },
        child: Container(
          height: double.infinity,
          width: 33,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _initialValue == days
                  ? FrontEndConfigs.kPrimaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          child: CustomText(
            text: days,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textColor: _initialValue == days
                ? FrontEndConfigs.kWhiteColor
                : FrontEndConfigs.kSubTextColor,
          ),
        ));
  }

  void onTapped(String days) {
    _initialValue = days;
    setState(() {});
  }
}
