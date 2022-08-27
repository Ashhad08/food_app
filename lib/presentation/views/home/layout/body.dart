import 'package:flutter/material.dart';
import 'package:food_app/backend/services/system.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/elements/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../backend/models/food_item.dart';
import '../../../elements/item_card.dart';
import '../../../elements/items_search_field.dart';
import '../../item_details/item_details_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemServices systemServices = SystemServices();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Recent Items',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                textColor: FrontEndConfigs.kPrimaryColor,
              ),
              const CustomText(
                text:
                    'Keep track of your food items or search for any Items by scanning barcode',
                fontSize: 14,
                align: TextAlign.start,
                fontWeight: FontWeight.w500,
                textColor: Color(0xff8D8D8D),
              ),
              const SizedBox(
                height: 15,
              ),
              const ItemsSearchField(),
              const SizedBox(
                height: 13,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamProvider.value(
                  value: systemServices.fetchAllUsersAllCategoriesFood(),
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
                                            ItemDetailsView(_foodList[index])));
                              },
                              child: ItemCard(
                                itemPicture: _foodList[index].image.toString(),
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
      ),
    );
  }
}
