import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/views/bottom_bar/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/views/auth/get_started/get_started_view.dart';

import 'configuration/front_end.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  bool isLogin = sharedPref.getBool("isLogin") ?? false;
  bool isSignUp = sharedPref.getBool("isSignUp") ?? false;
  runApp(MyApp(isLogin, isSignUp));
}

class MyApp extends StatelessWidget {
  const MyApp(this._isLogin, this._isSignUp, {Key? key}) : super(key: key);
  final bool _isLogin;
  final bool _isSignUp;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0, color: Color(0xffFAFAFA), centerTitle: true),
        colorScheme: const ColorScheme.light()
            .copyWith(primary: FrontEndConfigs.kPrimaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _isLogin || _isSignUp ? const BottomBar() : const GetStartedView(),
    );
  }
}
