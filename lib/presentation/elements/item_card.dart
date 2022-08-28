import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../configuration/front_end.dart';
import 'custom_text.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.itemPicture,
    required this.itemName,
    required this.categoryTitle,
    required this.description,
    required this.expiryDate,
    required this.itemQuantity,
  }) : super(key: key);
  final String itemPicture;
  final String itemName;
  final String categoryTitle;
  final String description;
  final String expiryDate;
  final String itemQuantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 9, right: 22, top: 10, bottom: 20),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
          color: FrontEndConfigs.kWhiteColor,
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: itemPicture.isEmpty
                ? Container(
                    height: 84,
                    width: 97,
                    color: const Color(0xffF0F0F0),
                  )
                : CachedNetworkImage(
                    imageUrl: itemPicture,
                    height: 84,
                    width: 97,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: itemName,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    CustomText(
                        text: 'QTY: $itemQuantity',
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                CustomText(
                    text: categoryTitle,
                    fontSize: 8,
                    textColor: FrontEndConfigs.kSubTextColor,
                    fontWeight: FontWeight.w400),
                const SizedBox(
                  height: 3,
                ),
                CustomText(
                    text: description,
                    fontSize: 10,
                    align: TextAlign.start,
                    maxLines: 2,
                    textColor: FrontEndConfigs.kSubTextColor,
                    fontWeight: FontWeight.w400),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const CustomText(
                        text: 'Expiry Date:',
                        fontSize: 10,
                        textColor: FrontEndConfigs.kSubTextColor,
                        fontWeight: FontWeight.w500),
                    expiryDate.isNotEmpty
                        ? CustomText(
                            text: ' $expiryDate',
                            fontSize: 10,
                            textColor: FrontEndConfigs.kSubTextColor,
                            fontWeight: FontWeight.w300)
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
