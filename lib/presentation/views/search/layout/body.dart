import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/configuration/back_end.dart';
import 'package:food_app/presentation/elements/item_card.dart';

import '../../../../configuration/front_end.dart';
import '../../../elements/custom_text.dart';
import '../../item_details/item_details_view.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({Key? key}) : super(key: key);

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  List<DocumentSnapshot> _searchedFoodList = [];
  List<DocumentSnapshot> _allFoodList = [];
  bool _isSearched = false;

  @override
  initState() {
    super.initState();
    _getAllFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Search Food',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              textColor: FrontEndConfigs.kPrimaryColor,
            ),
            const CustomText(
              text: 'Search food simply by entering food name',
              fontSize: 14,
              align: TextAlign.start,
              fontWeight: FontWeight.w500,
              textColor: Color(0xff8D8D8D),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (val) {
                _searchFood(val);
              },
              style: FrontEndConfigs.kTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA7A7A7)),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: const Color(0xffF0F0F0),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 23,
                    color: Color(0xff898989),
                  ),
                  suffixIcon: const Icon(
                    Icons.filter_list,
                    size: 23,
                    color: Color(0xff898989),
                  ),
                  hintText: 'Search here',
                  hintStyle: FrontEndConfigs.kTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffA7A7A7))),
            ),
            const SizedBox(
              height: 20,
            ),
            _searchedFoodList.isEmpty && _isSearched == true
                ? const Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: 'No Such Food Found',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      textColor: FrontEndConfigs.kPrimaryColor,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _searchedFoodList.length,
                        itemBuilder: (context, index) {
                          String showCategory() {
                            String category;
                            if (_searchedFoodList[index]["isVegetable"] ==
                                true) {
                              category = 'Vegetable';
                            } else if (_searchedFoodList[index]["isFruit"] ==
                                true) {
                              category = 'Fruit';
                            } else if (_searchedFoodList[index]["isDairy"] ==
                                true) {
                              category = 'Dairy';
                            } else if (_searchedFoodList[index]["isMeat"] ==
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
                                            _searchedFoodList[index]["foodId"]
                                                .toString(),
                                            _searchedFoodList[index]["name"]
                                                .toString(),
                                            _searchedFoodList[index]["image"]
                                                .toString(),
                                            _searchedFoodList[index]["quantity"]
                                                .toString(),
                                            _searchedFoodList[index]
                                                    ["expiryDate"]
                                                .toString(),
                                            _searchedFoodList[index]
                                                    ["description"]
                                                .toString(),
                                            _searchedFoodList[index]
                                                ["isVegetable"],
                                            _searchedFoodList[index]["isFruit"],
                                            _searchedFoodList[index]["isDairy"],
                                            _searchedFoodList[index]["isMeat"],
                                          )));
                            },
                            child: ItemCard(
                                itemPicture: _searchedFoodList[index]["image"],
                                itemName: _searchedFoodList[index]["name"],
                                categoryTitle: showCategory(),
                                description: _searchedFoodList[index]
                                    ["description"],
                                expiryDate: _searchedFoodList[index]
                                    ["expiryDate"],
                                itemQuantity: _searchedFoodList[index]
                                        ["quantity"]
                                    .toString()),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }

  _getAllFoodData() {
    BackEndConfigs.kFoodItemsCollection.get().then((value) {
      value.docs.map((e) {
        _allFoodList.add(e);
        setState(() {});
      }).toList();
    });
  }

  _searchFood(String val) {
    _searchedFoodList.clear();
    for (var i in _allFoodList) {
      var lowerCaseString = i["name"].toString().toLowerCase();
      var upperCaseString = i["name"].toString().toUpperCase();
      // we can add multiple things for search by adding + after var lowerCaseString = i["name"].toString().toLowerCase() + ...... like this
      var defaultCaseString = i["name"].toString();

      if (lowerCaseString.contains(val) ||
          defaultCaseString.contains(val) ||
          upperCaseString.contains(val)) {
        _searchedFoodList.add(i);
        setState(() {});
      } else {
        setState(() {
          _isSearched = true;
        });
      }
    }
  }
}
