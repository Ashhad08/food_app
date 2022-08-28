import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/backend/models/food_item.dart';
import 'package:food_app/configuration/back_end.dart';

import '../models/user.dart';

class SystemServices {
  // create user
  Future createUser(UserModel userModel) async {
    DocumentReference _ref = FirebaseFirestore.instance
        .collection('usersCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    return await _ref.set(userModel.toJson());
  }

  // display all users all categories food items
  Stream<List<FoodItemModel>> fetchAllUsersAllCategoriesFood() {
    return BackEndConfigs.kFoodItemsCollection.snapshots().map(
        (foodItemsList) => foodItemsList.docs
            .map((singleFoodItem) =>
                FoodItemModel.fromJson(singleFoodItem.data()))
            .toList());
  }

  // display vegetable food items
  Stream<List<FoodItemModel>> fetchCurrentUserVegetableFood() {
    return BackEndConfigs.kFoodItemsCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isVegetable", isEqualTo: true)
        .snapshots()
        .map((foodItemsList) => foodItemsList.docs
            .map((singleFoodItem) =>
                FoodItemModel.fromJson(singleFoodItem.data()))
            .toList());
  }

// display fruits food
  Stream<List<FoodItemModel>> fetchCurrentUserFruitsFood() {
    return BackEndConfigs.kFoodItemsCollection
        .where(
          "uid",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .where("isFruit", isEqualTo: true)
        .snapshots()
        .map((foodItemsList) => foodItemsList.docs
            .map((singleFoodItem) =>
                FoodItemModel.fromJson(singleFoodItem.data()))
            .toList());
  }

  // display dairy food
  Stream<List<FoodItemModel>> fetchCurrentUserDairyFood() {
    return BackEndConfigs.kFoodItemsCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isDairy", isEqualTo: true)
        .snapshots()
        .map((foodItemsList) => foodItemsList.docs
            .map((singleFoodItem) =>
                FoodItemModel.fromJson(singleFoodItem.data()))
            .toList());
  }

  // display Meat food
  Stream<List<FoodItemModel>> fetchCurrentUserMeatFood() {
    return BackEndConfigs.kFoodItemsCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isMeat", isEqualTo: true)
        .snapshots()
        .map((foodItemsList) => foodItemsList.docs
            .map((singleFoodItem) =>
                FoodItemModel.fromJson(singleFoodItem.data()))
            .toList());
  }

  Stream<UserModel> fetchCurrentUserName() {
    return FirebaseFirestore.instance
        .collection('usersCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((user) => UserModel.fromJson(user.data()!));
  }
}
