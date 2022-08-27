import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/backend/models/food_item.dart';
import 'package:food_app/configuration/back_end.dart';
import 'package:food_app/configuration/front_end.dart';

import 'package:food_app/presentation/elements/custom_text.dart';

class ItemDetailsViewBody extends StatefulWidget {
  const ItemDetailsViewBody(this._foodItemModel, {Key? key}) : super(key: key);
  final FoodItemModel _foodItemModel;

  @override
  State<ItemDetailsViewBody> createState() => _ItemDetailsViewBodyState();
}

class _ItemDetailsViewBodyState extends State<ItemDetailsViewBody> {
  List<dynamic> favouriteIdList = [];

  @override
  initState() {
    super.initState;
    _getFavouriteId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: widget._foodItemModel.image.toString().isEmpty
                      ? 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg'
                      : widget._foodItemModel.image.toString(),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 20, top: 17, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: widget._foodItemModel.name.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        Image.asset(
                          'assets/icons/edit.png',
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCategoryText(),
                        CustomText(
                            text: 'QTY: ${widget._foodItemModel.quantity}',
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        text:
                            'Expiry Date: ${widget._foodItemModel.expiryDate.toString()}',
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        text: widget._foodItemModel.description.toString(),
                        fontSize: 12,
                        align: TextAlign.start,
                        textColor: FrontEndConfigs.kSubTextColor,
                        fontWeight: FontWeight.w400),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 44,
                        width: 200,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: FrontEndConfigs.kPrimaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.transparent,
                            onPressed: () {
                              if (!(favouriteIdList.toString().contains(
                                  FirebaseAuth.instance.currentUser!.uid))) {
                                _markAsFavourite();
                              } else {
                                _removeAsFavourite();
                              }
                            },
                            child: CustomText(
                                text: !(favouriteIdList.toString().contains(
                                        FirebaseAuth.instance.currentUser!.uid))
                                    ? 'Add Favourite'
                                    : 'Remove Favourite',
                                fontSize: 12,
                                textColor: FrontEndConfigs.kPrimaryColor,
                                fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryText() {
    if (widget._foodItemModel.isVegetable == true) {
      return const CustomText(
          text: 'Vegetable',
          fontSize: 12,
          textColor: Color(0xff848484),
          fontWeight: FontWeight.w500);
    } else if (widget._foodItemModel.isFruit == true) {
      return const CustomText(
          text: 'Fruit',
          fontSize: 12,
          textColor: Color(0xff848484),
          fontWeight: FontWeight.w500);
    } else if (widget._foodItemModel.isDairy == true) {
      return const CustomText(
          text: 'Dairy',
          fontSize: 12,
          textColor: Color(0xff848484),
          fontWeight: FontWeight.w500);
    } else if (widget._foodItemModel.isMeat == true) {
      return const CustomText(
          text: 'Meat',
          fontSize: 12,
          textColor: Color(0xff848484),
          fontWeight: FontWeight.w500);
    } else {
      return const CustomText(
          text: 'No Category Selected',
          fontSize: 12,
          textColor: Color(0xff848484),
          fontWeight: FontWeight.w500);
    }
  }

  _markAsFavourite() {
    BackEndConfigs.kFoodItemsCollection.doc(widget._foodItemModel.foodId).set({
      "isFavourite":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    }, SetOptions(merge: true)).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: FrontEndConfigs.kPrimaryColor,
          content: CustomText(
            text: 'Successfully added as favourite',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: FrontEndConfigs.kWhiteColor,
          )));
      _getFavouriteId();
    });
  }

  _removeAsFavourite() {
    BackEndConfigs.kFoodItemsCollection.doc(widget._foodItemModel.foodId).set({
      "isFavourite":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
    }, SetOptions(merge: true)).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: FrontEndConfigs.kPrimaryColor,
          content: CustomText(
            text: 'Successfully removed as favourite',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: FrontEndConfigs.kWhiteColor,
          )));
    });
  }

  _getFavouriteId() async {
    BackEndConfigs.kFoodItemsCollection
        .doc(widget._foodItemModel.foodId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      setState(() {
        favouriteIdList.clear();
        favouriteIdList.add(snapshot.get("isFavourite"));
      });
    });
  }
}
