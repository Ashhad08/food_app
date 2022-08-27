import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../backend/models/food_item.dart';
import '../../../../backend/services/system.dart';
import '../../../../configuration/front_end.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/item_card.dart';
import '../../item_details/item_details_view.dart';

class FavouriteItemsViewBody extends StatelessWidget {
  const FavouriteItemsViewBody({Key? key}) : super(key: key);

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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.7,
              //   child: StreamProvider.value(
              //     value: systemServices.fetchCurrentUserFavouriteFood(),
              //     initialData: [FoodItemModel()],
              //     builder: (context, child) {
              //       List<FoodItemModel> _foodList =
              //           context.watch<List<FoodItemModel>>();
              //       if (_foodList.isEmpty == true) {
              //         return Column(
              //           children: const [
              //             SizedBox(
              //               height: 50,
              //             ),
              //             Center(
              //               child: CustomText(
              //                   text: 'List is Empty',
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold),
              //             )
              //           ],
              //         );
              //       } else {
              //         return ListView.builder(
              //             physics: const BouncingScrollPhysics(),
              //             itemCount: _foodList.length,
              //             itemBuilder: (context, index) {
              //               String showCategory() {
              //                 String category;
              //                 if (_foodList[index].isVegetable == true) {
              //                   category = 'Vegetable';
              //                 } else if (_foodList[index].isFruit == true) {
              //                   category = 'Fruit';
              //                 } else if (_foodList[index].isDairy == true) {
              //                   category = 'Dairy';
              //                 } else if (_foodList[index].isMeat == true) {
              //                   category = 'Meat';
              //                 } else {
              //                   category = 'UnDefined Category';
              //                 }
              //                 return category;
              //               }
              //
              //               return GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) =>
              //                               ItemDetailsView(_foodList[index])));
              //                 },
              //                 child: ItemCard(
              //                   itemPicture: _foodList[index].image.toString(),
              //                   itemName: _foodList[index].name.toString(),
              //                   categoryTitle: showCategory(),
              //                   description:
              //                       _foodList[index].description.toString(),
              //                   expiryDate:
              //                       _foodList[index].expiryDate.toString(),
              //                   itemQuantity:
              //                       _foodList[index].quantity.toString(),
              //                 ),
              //               );
              //             });
              //       }
              //     },
              //   ),
              // ),
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
