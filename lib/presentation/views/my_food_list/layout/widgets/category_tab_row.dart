// import 'package:flutter/material.dart';
//
// import '../../../../../configuration/front_end.dart';
// import '../../../../elements/custom_text.dart';
//
// class CategoryTabRow extends StatefulWidget {
//   const CategoryTabRow({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CategoryTabRow> createState() => _CategoryTabRowState();
// }
//
// class _CategoryTabRowState extends State<CategoryTabRow> {
//   bool isVegetableSelected = true;
//   bool isFruitsSelected = false;
//   bool isDairySelected = false;
//   bool isMeatSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20),
//         child: Row(
//           children: [
//             _buildCategoryCards(
//               'Vegetables',
//               isVegetableSelected,
//               () {},
//             ),
//             _buildCategoryCards(
//               'Fruits',
//               isFruitsSelected,
//               () {
//                 setState(() {
//                   isFruitsSelected = !isFruitsSelected;
//                 });
//               },
//             ),
//             _buildCategoryCards(
//               'Dairy',
//               isDairySelected,
//               () {
//                 setState(() {
//                   isDairySelected = !isDairySelected;
//                 });
//               },
//             ),
//             _buildCategoryCards(
//               'Meat',
//               isMeatSelected,
//               () {
//                 setState(() {
//                   isMeatSelected = !isMeatSelected;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryCards(final String categoryName) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         height: 27,
//         width: 112,
//         margin: const EdgeInsets.only(right: 9),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//           color: isSelected
//               ? FrontEndConfigs.kPrimaryColor
//               : FrontEndConfigs.kPrimaryColor.withOpacity(0.05),
//         ),
//         child: Center(
//             child: CustomText(
//           text: categoryName,
//           fontSize: 12,
//           fontWeight: FontWeight.w400,
//           textColor: isSelected
//               ? FrontEndConfigs.kWhiteColor
//               : FrontEndConfigs.kPrimaryColor,
//         )),
//       ),
//     );
//   }
// }
