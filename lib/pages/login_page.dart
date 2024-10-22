// ignore_for_file: use_build_context_synchronously

import 'package:bbb/components/app_alert_dialog.dart';
import 'package:bbb/components/app_text_form_field.dart';
import 'package:bbb/components/back_arrow_widget.dart';
import 'package:bbb/components/button_widget.dart';
import 'package:bbb/pages/email_verification_page.dart';
import 'package:bbb/pages/main_page.dart';
import 'package:bbb/pages/reset_password_page.dart';
import 'package:bbb/values/app_colors.dart';
import 'package:bbb/values/app_constants.dart';
import 'package:bbb/utils/screen_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this for shared preferences
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  Future<void> _saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void signInUser(String emailAddress, String password) async {
    if (emailAddress.isEmpty || password.isEmpty) {
      showBottomAlert(context, 'Please fill out the inputs');
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });

      final url = Uri.parse(
          'https://bbbdev1.wpenginepowered.com/wp-json/jwt-auth/v1/token');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'username': emailAddress,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveLoginState(true);
        String token = data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        debugPrint('Error: ${response.statusCode}');
        showBottomAlert(context, 'Lgino failed');
      }
    } catch (e) {
      debugPrint('Error: $e');
      showBottomAlert(context, 'An error occurred');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await _saveLoginState(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: media.width,
                  height: media.height / 3.5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: media.width,
                  height: media.height / 2.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/loginbackground.jpg'),
                        fit: BoxFit.cover,
                        opacity: 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: ScreenUtil.horizontalScale(4)),
                    width: media.width,
                    height: media.height / 10,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/logo1.png'),
                          fit: BoxFit.fitHeight,
                          opacity: 1),
                    ),
                  ),
                ),
                BackArrowWidget(
                    onPress: () =>
                        {Navigator.pushNamed(context, '/onboarding')}),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: media.width,
                height: media.height / 1.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/loginbackground.jpg'),
                      fit: BoxFit.cover,
                      opacity: 1),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: media.width,
                height: media.height / 1.79,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 55,
                      ),
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 26,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextFormField(
                        hintText: 'Your Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {},
                        // validator: (value) {
                        //   return value!.isEmpty
                        //       ? 'Please, Enter Email Address'
                        //       : AppConstants.emailRegex.hasMatch(value)
                        //           ? null
                        //           : 'Invalid Email Address';
                        // },
                        controller: emailController,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                const Size(48, 48),
                              ),
                            ),
                            icon: const Icon(
                              Icons.person,
                              color: Color(0XFFd9d9d9),
                            ),
                          ),
                        ),
                      ),
                      AppTextFormField(
                        hintText: 'Your Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {},
                        // validator: (value) {
                        //   return value!.isEmpty
                        //       ? 'Please, Enter Password'
                        //       : value.length <= 5
                        //           ? 'Password length must be greater than 6'
                        //           : null;
                        // },
                        controller: passwordController,
                        obscureText: isObscure,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                const Size(48, 48),
                              ),
                            ),
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0XFFd9d9d9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFFA51E22),
                            ),
                            text: "Forgot",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        const ResetPasswordScreen(),
                                  ),
                                );
                              },
                          ),
                          TextSpan(
                            style: const TextStyle(
                                fontSize: 15, color: Color(0xFF848484)),
                            text: " password?",
                          ),
                        ],
                      )),
                      SizedBox(
                        height: ScreenUtil.verticalScale(7),
                      ),
                      ButtonWidget(
                        text: 'Sign in',
                        textColor: Colors.white,
                        color: AppColors.primaryColor,
                        onPress: () {
                          if (_formKey.currentState?.validate() == true) {
                            signInUser(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        isLoading: isLoading,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showBottomAlert(BuildContext context, String msg) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20.0,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );

  overlayState?.insert(overlayEntry);

  // Remove the alert after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
