import 'package:flutter/material.dart';

import 'layout/body.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView(
      this._foodId,
      this._foodName,
      this._foodImage,
      this._foodQuantity,
      this._foodExpiryDate,
      this._foodDescription,
      this._isVegetable,
      this._isFruit,
      this._isDairy,
      this._isMeat,
      {Key? key})
      : super(key: key);
  final String _foodId;
  final String _foodName;
  final String _foodImage;
  final String _foodQuantity;
  final String _foodExpiryDate;
  final String _foodDescription;
  final bool _isVegetable;
  final bool _isFruit;
  final bool _isDairy;
  final bool _isMeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ItemDetailsViewBody(
        _foodId,
        _foodName,
        _foodImage,
        _foodQuantity,
        _foodExpiryDate,
        _foodDescription,
        _isVegetable,
        _isFruit,
        _isDairy,
        _isMeat,
      ),
    );
  }
}
