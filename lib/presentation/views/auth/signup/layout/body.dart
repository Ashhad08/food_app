import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/backend/models/user.dart';
import 'package:food_app/backend/services/auth.dart';
import 'package:food_app/backend/services/system.dart';

import 'package:food_app/presentation/views/bottom_bar/bottom_bar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../configuration/front_end.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';
import '../../login/layout/widgets/auth_icon_card.dart';
import '../../login/layout/widgets/auth_text_field.dart';
import '../../login/layout/widgets/top_stacked_container.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({Key? key}) : super(key: key);

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemServices systemServices = SystemServices();
    AuthServices authServices = AuthServices();
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.2,
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
                                      text: "Create new account",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  AuthTextField(
                                    hintText: 'Name',
                                    isPasswordField: false,
                                    prefixIcon: Icons.person_outline,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter your Name ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _nameController,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthTextField(
                                    hintText: 'Email address',
                                    isPasswordField: false,
                                    prefixIcon: Icons.mail_outline,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter your Email ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _emailController,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthTextField(
                                    hintText: 'Password',
                                    isPasswordField: true,
                                    obscureText: true,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter your Password ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixIcon: Icons.lock_outline,
                                    controller: _passwordController,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: AppButton(
                                      text: "Sign Up",
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          makeLoadingTrue();
                                          authServices
                                              .signUpUser(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text)
                                              .then((value) async {
                                            await systemServices
                                                .createUser(UserModel(
                                                    uid: FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    name: _nameController.text,
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text))
                                                .then((value) {
                                              _setIsSignUp();
                                              makeLoadingFalse();
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomBar()),
                                                (route) => false,
                                              );
                                            }).onError((error, stackTrace) {
                                              makeLoadingFalse();
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
                                                        textColor:
                                                            FrontEndConfigs
                                                                .kWhiteColor,
                                                      )));
                                            });
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
                                        text: 'I already have an account? ',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        textColor: Color(0xff959595),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const CustomText(
                                          text: 'Sign in ',
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
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'By signing up you accept our\n',
                                        style: FrontEndConfigs.kTextStyle),
                                    TextSpan(
                                        text: 'Term of use',
                                        style: FrontEndConfigs.kTextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline)),
                                    const TextSpan(
                                        text: ' and ',
                                        style: FrontEndConfigs.kTextStyle),
                                    TextSpan(
                                        text: 'Privacy Policy ',
                                        style: FrontEndConfigs.kTextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline)),
                                  ]))
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

  _setIsSignUp() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("isSignUp", true);
  }

  makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }
}
