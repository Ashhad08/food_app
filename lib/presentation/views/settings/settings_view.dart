import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/configuration/back_end.dart';
import 'package:food_app/presentation/views/auth/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../configuration/front_end.dart';
import 'layout/body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FrontEndConfigs.kAppbarLogo,
        actions: [
          IconButton(
            tooltip: "Log Out",
            splashRadius: 30,
            onPressed: () {
              _clearSharedPreferences();
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.logout,
              size: 25,
              color: FrontEndConfigs.kPrimaryColor,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: const SettingsViewBody(),
    );
  }

  _clearSharedPreferences() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();
  }
}
