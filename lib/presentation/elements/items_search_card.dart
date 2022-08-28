// import 'package:flutter/material.dart';
//
// import '../../configuration/front_end.dart';
//
// class ItemsSearchField extends StatelessWidget {
//   const ItemsSearchField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 44,
//       child: TextField(
//         style: FrontEndConfigs.kTextStyle.copyWith(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xffA7A7A7)),
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(8)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(8)),
//             filled: true,
//             fillColor: const Color(0xffF0F0F0),
//             contentPadding: const EdgeInsets.only(top: 10),
//             prefixIcon: const Icon(
//               Icons.search_rounded,
//               size: 20,
//               color: Color(0xff898989),
//             ),
//             suffixIcon: const Icon(
//               Icons.menu,
//               size: 20,
//               color: Color(0xff898989),
//             ),
//             hintText: 'Search here',
//             hintStyle: FrontEndConfigs.kTextStyle.copyWith(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: const Color(0xffA7A7A7))),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_app/presentation/elements/custom_text.dart';
import 'package:food_app/presentation/views/search/search_view.dart';

class ItemSearchContainer extends StatelessWidget {
  const ItemSearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchView()));
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: const [
            SizedBox(
              width: 15,
            ),
            Icon(
              Icons.search_rounded,
              size: 20,
              color: Color(0xff898989),
            ),
            SizedBox(
              width: 13,
            ),
            CustomText(
              text: "Search here",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: Color(0xffA7A7A7),
            ),
            Spacer(),
            Icon(
              Icons.menu,
              size: 20,
              color: Color(0xff898989),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
