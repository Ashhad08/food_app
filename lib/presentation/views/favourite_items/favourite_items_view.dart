import 'package:flutter/material.dart';

import '../../../configuration/front_end.dart';
import 'layout/body.dart';

class FavouriteItemsView extends StatelessWidget {
  const FavouriteItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FrontEndConfigs.kAppbarLogo,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: FrontEndConfigs.kSubTextColor,
          ),
        ),
      ),
      body: const FavouriteItemsViewBody(),
    );
  }
}
