import 'package:cloud_firestore/cloud_firestore.dart';

import '../../configuration/back_end.dart';
import '../models/food_item.dart';

class UserServices {
  //add new foodItem
  Future addNewFoodItem(FoodItemModel foodItemModel) async {
    DocumentReference _ref =
        FirebaseFirestore.instance.collection('foodItemsCollection').doc();
    return await _ref.set(foodItemModel.toJson(_ref.id));
  }

  // delete/remove Food item
  Future removeFoodItem(String foodId) async {
    return await BackEndConfigs.kFoodItemsCollection.doc(foodId).delete();
  }
}
