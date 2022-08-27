import 'package:flutter/material.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/views/grocery_list/grocery_list_view.dart';
import 'package:food_app/presentation/views/home/home_view.dart';
import 'package:food_app/presentation/views/my_food_list/my_food_list_view.dart';
import 'package:food_app/presentation/views/settings/settings_view.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeView(),
    MyFoodListView(),
    GroceryListView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'My Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Grocery List',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: FrontEndConfigs.kWhiteColor,
        elevation: 5,
        currentIndex: _selectedIndex,
        selectedItemColor: FrontEndConfigs.kPrimaryColor,
        unselectedItemColor: FrontEndConfigs.kSubTextColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
