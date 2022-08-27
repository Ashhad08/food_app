// To parse this JSON data, do
//
//     final foodItemModel = foodItemModelFromJson(jsonString);

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/configuration/back_end.dart';

FoodItemModel foodItemModelFromJson(String str) =>
    FoodItemModel.fromJson(json.decode(str));

String foodItemModelToJson(FoodItemModel data) =>
    json.encode(data.toJson(data.foodId.toString()));

class FoodItemModel {
  FoodItemModel({
    this.uid,
    this.foodId,
    this.name,
    this.image,
    this.quantity,
    this.expiryDate,
    this.description,
    this.isVegetable,
    this.isFruit,
    this.isDairy,
    this.isMeat,
    this.isFromFridge,
    this.isFromFreezer,
    this.isFromPantry,
  });

  String? uid;
  String? foodId;
  String? name;
  String? image;
  int? quantity;
  String? expiryDate;
  String? description;
  bool? isVegetable;
  bool? isFruit;
  bool? isDairy;
  bool? isMeat;
  bool? isFromFridge;
  bool? isFromFreezer;
  bool? isFromPantry;

  factory FoodItemModel.fromJson(Map<String, dynamic> json) => FoodItemModel(
        uid: json["uid"],
        foodId: json["foodId"],
        name: json["name"],
        image: json["image"],
        quantity: json["quantity"],
        expiryDate: json["expiryDate"],
        description: json["description"],
        isVegetable: json["isVegetable"],
        isFruit: json["isFruit"],
        isDairy: json["isDairy"],
        isMeat: json["isMeat"],
        isFromFridge: json["isFromFridge"],
        isFromFreezer: json["isFromFreezer"],
        isFromPantry: json["isFromPantry"],
      );

  Map<String, dynamic> toJson(String id) => {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "foodId": id,
        "name": name,
        "image": image,
        "quantity": quantity,
        "expiryDate": expiryDate,
        "description": description,
        "isVegetable": isVegetable,
        "isFruit": isFruit,
        "isDairy": isDairy,
        "isMeat": isMeat,
        "isFromFridge": isFromFridge,
        "isFromFreezer": isFromFreezer,
        "isFromPantry": isFromPantry,
      };
}
// {
// "foodId" : "",
// "name" : "",
// "image" : "",
// "quantity" : 1,
// "expiryDate" : "",
// "description" : "",
// "isFavourite" : false,
//
// "isVegetable": true,
// "isFruit": false,
// "isDairy" : false,
// "isMeat" : false,
//
// "isFromFridge" : false,
// "isFromFreezer": false,
// "isFromPantry" : false
// }
