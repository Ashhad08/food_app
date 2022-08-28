import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/configuration/back_end.dart';

import '../../../../configuration/front_end.dart';
import '../../../elements/custom_text.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({Key? key}) : super(key: key);

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  List<DocumentSnapshot> _searchedFoodList = [];
  List<DocumentSnapshot> _allFoodList = [];

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
            SizedBox(
              height: 15,
            ),
            TextField(
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
            SizedBox(
              height: 20,
            ),
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
      // we can add multiple things for search by adding + after var lowerCaseString = i["name"].toString().toLowerCase() + ...... like this

    }
  }
}
