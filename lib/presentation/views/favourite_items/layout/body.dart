import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/configuration/back_end.dart';

import '../../../../configuration/front_end.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/item_card.dart';
import '../../item_details/item_details_view.dart';

class FavouriteItemsViewBody extends StatefulWidget {
  const FavouriteItemsViewBody({Key? key}) : super(key: key);

  @override
  State<FavouriteItemsViewBody> createState() => _FavouriteItemsViewBodyState();
}

class _FavouriteItemsViewBodyState extends State<FavouriteItemsViewBody> {
  final List<DocumentSnapshot> _favouriteItemsList = [];

  @override
  initState() {
    super.initState();
    _getFavouriteItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Favourite Items',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                textColor: FrontEndConfigs.kPrimaryColor,
              ),
              const CustomText(
                text: 'List of your favourite items',
                fontSize: 14,
                align: TextAlign.start,
                fontWeight: FontWeight.w500,
                textColor: Color(0xff8D8D8D),
              ),
              const SizedBox(
                height: 16,
              ),
              _favouriteItemsList.isEmpty
                  ? Column(
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        CustomText(
                            text:
                                'No Favourite Food Items Found.',
                            fontSize: 16,
                            fontWeight: FontWeight.bold)
                      ],
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: _favouriteItemsList.length,
                          itemBuilder: (context, index) {
                            String showCategory() {
                              String category;
                              if (_favouriteItemsList[index]["isVegetable"] ==
                                  true) {
                                category = 'Vegetable';
                              } else if (_favouriteItemsList[index]
                                      ["isFruit"] ==
                                  true) {
                                category = 'Fruit';
                              } else if (_favouriteItemsList[index]
                                      ["isDairy"] ==
                                  true) {
                                category = 'Dairy';
                              } else if (_favouriteItemsList[index]["isMeat"] ==
                                  true) {
                                category = 'Meat';
                              } else {
                                category = 'UnDefined Category';
                              }
                              return category;
                            }

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemDetailsView(
                                              _favouriteItemsList[index]
                                                      ["foodId"]
                                                  .toString(),
                                              _favouriteItemsList[index]["name"]
                                                  .toString(),
                                              _favouriteItemsList[index]
                                                      ["image"]
                                                  .toString(),
                                              _favouriteItemsList[index]
                                                      ["quantity"]
                                                  .toString(),
                                              _favouriteItemsList[index]
                                                      ["expiryDate"]
                                                  .toString(),
                                              _favouriteItemsList[index]
                                                      ["description"]
                                                  .toString(),
                                              _favouriteItemsList[index]
                                                  ["isVegetable"],
                                              _favouriteItemsList[index]
                                                  ["isFruit"],
                                              _favouriteItemsList[index]
                                                  ["isDairy"],
                                              _favouriteItemsList[index]
                                                  ["isMeat"],
                                            )));
                              },
                              child: ItemCard(
                                  itemPicture: _favouriteItemsList[index]
                                      ["image"],
                                  itemName: _favouriteItemsList[index]["name"],
                                  categoryTitle: showCategory(),
                                  description: _favouriteItemsList[index]
                                      ["description"],
                                  expiryDate: _favouriteItemsList[index]
                                      ["expiryDate"],
                                  itemQuantity: _favouriteItemsList[index]
                                          ["quantity"]
                                      .toString()),
                            );
                          }),
                    ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getFavouriteItems() {
    BackEndConfigs.kFoodItemsCollection
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _favouriteItemsList.clear();
      setState(() {});
      snapshot.docs.forEach((element) {
        if (element["isFavourite"]
            .toString()
            .contains(FirebaseAuth.instance.currentUser!.uid)) {
          _favouriteItemsList.add(element);
          setState(() {});
        }
      });
    });
  }
}
