import 'package:flutter/material.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/views/add_new_item/add_new_item_view.dart';

import 'layout/body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FrontEndConfigs.kAppbarLogo,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            splashRadius: 30,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewItemView()));
            },
            icon: const Icon(
              Icons.add_circle_outline,
              size: 25,
              color: FrontEndConfigs.kPrimaryColor,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: const HomeViewBody(),
    );
  }
}
