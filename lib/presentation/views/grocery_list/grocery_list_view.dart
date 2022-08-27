import 'package:flutter/material.dart';
import 'package:food_app/configuration/front_end.dart';

import 'layout/body.dart';

class GroceryListView extends StatelessWidget {
  const GroceryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FrontEndConfigs.kAppbarLogo,
      ),
      body: const GroceryListViewBody(),
    );
  }
}
