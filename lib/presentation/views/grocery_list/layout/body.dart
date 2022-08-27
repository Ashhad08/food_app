import 'package:flutter/material.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/elements/custom_text.dart';
import 'package:food_app/presentation/elements/items_search_field.dart';

import 'widgets/grocery_list_items_tile.dart';
import 'widgets/my_pop_up_menu.dart';

class GroceryListViewBody extends StatelessWidget {
  const GroceryListViewBody({Key? key}) : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CustomText(
                      text: 'Grocery List',
                      fontSize: 28,
                      textColor: FrontEndConfigs.kPrimaryColor,
                      fontWeight: FontWeight.bold),
                  MyPopUpButton(),
                ],
              ),
              const CustomText(
                  text: 'Create your grocery list and\nShare with your friends',
                  fontSize: 14,
                  align: TextAlign.start,
                  textColor: Color(0xff8D8D8D),
                  fontWeight: FontWeight.w500),
              const SizedBox(
                height: 16,
              ),
              const ItemsSearchField(),
              const SizedBox(
                height: 20,
              ),
              GroceryListItemsTile(
                groceryItemName: 'Fruits and Vegetables',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Bread and Pastries',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Milk & Cheese',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Meat and fish',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Ingredients & spicy',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Frozen & convenience',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Grain Products',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Snacks & Sweets',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Beverages',
                onPressed: () {},
              ),
              GroceryListItemsTile(
                groceryItemName: 'Pet Supplies',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
