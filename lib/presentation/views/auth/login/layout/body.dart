import 'package:flutter/material.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/elements/app_button.dart';
import 'package:food_app/presentation/elements/custom_text.dart';
import 'package:food_app/presentation/views/bottom_bar/bottom_bar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../backend/services/auth.dart';
import '../../signup/signup_view.dart';
import 'widgets/auth_icon_card.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/top_stacked_container.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    return LoadingOverlay(
      opacity: 0.2,
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: FrontEndConfigs.kWhiteColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TopStackedContainer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const CustomText(
                                      text: "Login to your account",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  AuthTextField(
                                    hintText: 'Email address',
                                    isPasswordField: false,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter your Email ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixIcon: Icons.mail_outline,
                                    controller: _emailController,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthTextField(
                                    hintText: 'Password',
                                    isPasswordField: true,
                                    prefixIcon: Icons.lock_outline,
                                    obscureText: true,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter your Password ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _passwordController,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomText(
                                      text: 'Forgot Password?',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      textColor: Color(0xff3B3B3C),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: AppButton(
                                      text: "Login",
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _makeLoadingTrue();
                                          authServices
                                              .signInUser(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text)
                                              .then((value) {
                                            _setIsLogin();
                                            _makeLoadingFalse();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomBar()),
                                              (route) => false,
                                            );
                                          }).onError((error, stackTrace) {
                                            _makeLoadingFalse();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        FrontEndConfigs
                                                            .kPrimaryColor,
                                                    content: CustomText(
                                                      text:
                                                          'Error occurred, Kindly try again',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textColor: FrontEndConfigs
                                                          .kWhiteColor,
                                                    )));
                                          });
                                        }
                                      },
                                      height: 58,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 27,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomText(
                                        text: 'Don’t have an account? ',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        textColor: Color(0xff959595),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpView()));
                                        },
                                        child: const CustomText(
                                          text: 'Sign up ',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textColor: Color(0xff4CAF50),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 1,
                                          width: 67,
                                          color: const Color(0xff707070),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const CustomText(
                                            text: 'OR',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          height: 1,
                                          width: 67,
                                          color: const Color(0xff707070),
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: 'Login using social media account',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      textColor: Color(0xff959595),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      AuthIconCard(
                                        imagePath: 'assets/icons/facebook.png',
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      AuthIconCard(
                                        imagePath: 'assets/icons/google.png',
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      AuthIconCard(
                                        imagePath: 'assets/icons/apple.png',
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: -20,
                        bottom: -100,
                        child: Image.asset(
                          'assets/images/login_support_5.png',
                          height: 266,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setIsLogin() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("isLogin", true);
  }

  _makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  _makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }
}
