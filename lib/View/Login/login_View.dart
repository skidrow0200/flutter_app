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
import 'package:cratch/widgets/LoginView/modal.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isModalVisible = false;
  var _Appuri, _session, signClient, response;

  void _toggleModalVisibility() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });
  }

  void _handleTap() {
    if (_isModalVisible) {
      setState(() {
        _isModalVisible = false;
      });
    }
  }

  SignInstanceCreate() async {
    signClient = await SignClient.createInstance(
      projectId: '15faabd2ceb2a486be25c61d1b5a587a',
      metadata: const PairingMetadata(
        name: 'Cratch',
        description: 'A dapp that can request that transactions be signed',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );
  }
  
  getUri() async{
    response = await signClient.connect(requiredNamespaces: {
      'eip155': const RequiredNamespace(
          chains: ['eip155:1'], // Ethereum chain
          methods: ['personal_sign'], // Requestable Methods
          events: []),
    });

    Uri? uri = response.uri;
    _Appuri = uri.toString();
  }

  launchWithMetamask(BuildContext context) async {
    await getUri();
    await launchUrlString(_Appuri, mode: LaunchMode.externalApplication);

    _session = await response.session.future;

    signClient.onSessionConnect.subscribe((SessionConnect? session) {
      print(session);
    });
  }
  
  launchWithWalletConnect(BuildContext context) async{
    await getUri();
    _toggleModalVisibility();
    
    _session = await response.session.future;

    if(_session != null) _toggleModalVisibility();

    signClient.onSessionConnect.subscribe((SessionConnect? session) {
      print(session);
    });
  }

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SignInstanceCreate();
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleTap,
        child: Stack(
          children: [
            Container(
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
                                ontap: () => {launchWithMetamask(context)},
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
                                ontap: () => {
                                  launchWithWalletConnect(context)
                                },
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
            if(_isModalVisible)
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5
                ),
                child: Center(
                  child: WalletConnectModal(uri: _Appuri,),
                ),
              )
          ],
        ),
      ),
    );
  }
}



// Future<void> _storeWalletAddress(String address, String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('wallet_address', address);
//   await prefs.setString('token', token);
// }