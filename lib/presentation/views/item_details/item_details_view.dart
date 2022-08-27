import 'package:flutter/material.dart';

import '../../../backend/models/food_item.dart';
import 'layout/body.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView(this._foodItemModel, {Key? key}) : super(key: key);
  final FoodItemModel _foodItemModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ItemDetailsViewBody(_foodItemModel),
    );
  }
}
