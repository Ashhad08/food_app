import 'package:flutter/material.dart';
import 'package:food_app/backend/models/food_item.dart';
import 'package:food_app/backend/services/system.dart';
import 'package:food_app/presentation/views/item_details/item_details_view.dart';
import 'package:provider/provider.dart';

import '../../../../configuration/front_end.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/item_card.dart';
import '../../../elements/items_search_card.dart';

class MyFoodListViewBody extends StatefulWidget {
  const MyFoodListViewBody({Key? key}) : super(key: key);

  @override
  State<MyFoodListViewBody> createState() => _MyFoodListViewBodyState();
}

class _MyFoodListViewBodyState extends State<MyFoodListViewBody> {
  String _initialCategory = 'Vegetables';
  SystemServices systemServices = SystemServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomText(
                    text: 'My Food List',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    textColor: FrontEndConfigs.kPrimaryColor,
                  ),
                  CustomText(
                    text:
                        'Keep track of your food items or search for any Items by scanning barcode',
                    fontSize: 14,
                    align: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    textColor: Color(0xff8D8D8D),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    _buildCategoryCards('Vegetables'),
                    _buildCategoryCards('Fruits'),
                    _buildCategoryCards('Dairy'),
                    _buildCategoryCards('Meat'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const ItemSearchContainer(),
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: StreamProvider.value(
                      value: _streamProvider(),
                      initialData: [FoodItemModel()],
                      builder: (context, child) {
                        List<FoodItemModel> _foodList =
                            context.watch<List<FoodItemModel>>();
                        if (_foodList.isEmpty == true) {
                          return Column(
                            children: const [
                              SizedBox(
                                height: 50,
                              ),
                              CustomText(
                                  text:
                                      'No Food Items Found. Click The Top Right Button To Create New Food Items.',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)
                            ],
                          );
                        } else {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: _foodList.length,
                              itemBuilder: (context, index) {
                                String showCategory() {
                                  String category;
                                  if (_foodList[index].isVegetable == true) {
                                    category = 'Vegetable';
                                  } else if (_foodList[index].isFruit == true) {
                                    category = 'Fruit';
                                  } else if (_foodList[index].isDairy == true) {
                                    category = 'Dairy';
                                  } else if (_foodList[index].isMeat == true) {
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
                                            builder: (context) =>
                                                ItemDetailsView(
                                                    _foodList[index]
                                                        .foodId
                                                        .toString(),
                                                    _foodList[index]
                                                        .name
                                                        .toString(),
                                                    _foodList[index]
                                                        .image
                                                        .toString(),
                                                    _foodList[index]
                                                        .quantity
                                                        .toString(),
                                                    _foodList[index]
                                                        .expiryDate
                                                        .toString(),
                                                    _foodList[index]
                                                        .description
                                                        .toString(),
                                                    _foodList[index]
                                                        .isVegetable!,
                                                    _foodList[index].isFruit!,
                                                    _foodList[index].isDairy!,
                                                    _foodList[index].isMeat!)));
                                  },
                                  child: ItemCard(
                                    itemPicture:
                                        _foodList[index].image.toString(),
                                    itemName: _foodList[index].name.toString(),
                                    categoryTitle: showCategory(),
                                    description:
                                        _foodList[index].description.toString(),
                                    expiryDate:
                                        _foodList[index].expiryDate.toString(),
                                    itemQuantity:
                                        _foodList[index].quantity.toString(),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<FoodItemModel>> _streamProvider() {
    if (_initialCategory == 'Vegetables') {
      return systemServices.fetchCurrentUserVegetableFood();
    } else if (_initialCategory == 'Fruits') {
      return systemServices.fetchCurrentUserFruitsFood();
    } else if (_initialCategory == 'Dairy') {
      return systemServices.fetchCurrentUserDairyFood();
    } else {
      return systemServices.fetchCurrentUserMeatFood();
    }
  }

  Widget _buildCategoryCards(String categoryName) {
    return GestureDetector(
      onTap: () {
        _onTapped(categoryName);
      },
      child: Container(
        height: 27,
        width: 112,
        margin: const EdgeInsets.only(right: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: _initialCategory == categoryName
              ? FrontEndConfigs.kPrimaryColor
              : FrontEndConfigs.kPrimaryColor.withOpacity(0.05),
        ),
        child: Center(
            child: CustomText(
          text: categoryName,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          textColor: _initialCategory == categoryName
              ? FrontEndConfigs.kWhiteColor
              : FrontEndConfigs.kPrimaryColor,
        )),
      ),
    );
  }

  void _onTapped(String category) {
    _initialCategory = category;
    setState(() {});
  }
}
