import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cratch/Utils/app_style.dart';
import 'package:cratch/Utils/color_constant.dart';
import 'package:cratch/Utils/image_constant.dart';
import 'package:cratch/widgets/Sizebox/sizedboxheight.dart';
import 'package:cratch/widgets/customtext.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../widgets/GradientTextWidget.dart';
import '../../widgets/customButton.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Future<void> _storeWalletAddress(String address, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wallet_address', address);
    await prefs.setString('token', token);
  }

  Future<void> handleUser() async {
    const url =
        'https://account.cratch.io/api'; // Replace with your actual API URL

    try {
      final prefs = await SharedPreferences.getInstance();
      var wallet = prefs.getString('wallet_address');
      var token = prefs.getString('token');
      final response = await http.get(
          Uri.parse('$url/user/${wallet?.toLowerCase()}'),
          headers: {'Authorization': 'Bearer $token'});
      final result = json.decode(response.body);

      if ((jsonDecode(result.body) as Map<String, dynamic>)
          .containsKey('status')) {
        final userBody = {
          'userId': wallet?.toLowerCase(),
          'username': wallet?.toLowerCase(),
          'isOnline': true,
        };

        final addResponse = await http.post(Uri.parse('$url/user/add'),
            body: json.encode(userBody),
            headers: {
              'Authorization': 'Bearer $token'
            }); // Replace with your actual authorization token header

        final addUserResult = json.decode(addResponse.body);
        if (addUserResult.statusCode == 200) {
          /// the code logic, redirect to home page
          return;
        }
      } else {
        /// the code logic, redirect to home page
        return;
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppImages.newbg),
          fit: BoxFit.fill,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  AppImages.logoname,
                  width: 150,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    GradientTextWidget(
                      size: 25,
                      text: 'Login',
                    ),
                    CustomSizedBoxHeight(height: 20.h),
                    CustomText(
                      textStyle: AppStyle.textStyle13Regular,
                      title:
                          'This party’s just getting started! Sign in to\n join the fun. ',
                      textAlign: TextAlign.center,
                      maxline: 2,
                    ),
                    CustomSizedBoxHeight(height: 20),
                    CustomButton(
                        width: double.infinity,
                        ontap: () async {},
                        image: AppImages.metamask,
                        title: 'MetaMask',
                        AppStyle: AppStyle.textStyle14whiteSemiBold,
                        // color: AppColors.mainColor,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.mainColor.withOpacity(0.4),
                            AppColors.indigo.withOpacity(0.4),
                            AppColors.indigo.withOpacity(0.4),
                          ],
                        )),
                    CustomSizedBoxHeight(height: 20.h),
                    CustomButton(
                        width: double.infinity,
                        ontap: () async {},
                        AppStyle: AppStyle.textStyle14whiteSemiBold,
                        image: AppImages.walletconnectpng,
                        title: 'WalletConnect',
                        // color: AppColors.mainColor,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.mainColor.withOpacity(0.4),
                            AppColors.indigo.withOpacity(0.4),
                            AppColors.indigo.withOpacity(0.4),
                          ],
                        )),
                    CustomSizedBoxHeight(height: 20.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
