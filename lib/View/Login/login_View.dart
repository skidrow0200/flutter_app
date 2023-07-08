import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cratch/Utils/app_style.dart';
import 'package:cratch/Utils/color_constant.dart';
import 'package:cratch/Utils/image_constant.dart';
import 'package:cratch/widgets/Sizebox/sizedboxheight.dart';
import 'package:cratch/widgets/customtext.dart';
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
  bool _isReady = false;

  late SignClient _signClient;
  late ConnectResponse _response;
  late String _appUri;
  late SessionData _session;
  late String? _accountAddress;
  late dynamic _signature;

  void _toggleModalVisibility() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });
  } // Toggles the visibility of the modal

  void _handleTap() {
    if (_isModalVisible) {
      setState(() {
        _isModalVisible = false;
      });
    }
  } // Handles the modal visibility based on where the user is tapping

  _signInstanceCreate() async {
    try {
      _signClient = await SignClient.createInstance(
        projectId: '15faabd2ceb2a486be25c61d1b5a587a',
        metadata: const PairingMetadata(
          name: 'Cratch',
          description: 'A dapp that can request that transactions be signed',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
    } catch (exp) {
      debugPrint("$exp");
    }
  } // Creates the signClient for the dapp to use

  _getUri() async {
    try {
      _response = await _signClient.connect(requiredNamespaces: {
        'eip155': const RequiredNamespace(
            chains: [], // Ethereum chain
            methods: [
              'eth_signTransaction',
              'personal_sign'
            ], // Requestable Methods
            events: [],
        ),

      });

      Uri? uri = _response.uri;
      _appUri = uri.toString();
    } catch (exp) {
      debugPrint("$exp");
    }
  } // Generates the uri from the signClient instance

  getPos(str, subStr, i) {
    print("String $str");
    print("SubStr $subStr");
    print("I $i");
    return str.split(subStr).sublist(0,  2).join(subStr).length;
  }

  _launchWithMetamask() async {
    try {
      await _getUri();
      await launchUrlString(_appUri, mode: LaunchMode.externalApplication);

      _session = await _response.session.future;

      _signClient.onSessionConnect.subscribe((SessionConnect? session) async {
       await launchUrlString(_appUri, mode: LaunchMode.externalApplication);

       var chain = session?.session.namespaces['eip155']?.accounts[0].substring(0, getPos(session?.session.namespaces['eip155']?.accounts[0], ':', 2));
       debugPrint("Chain $chain");
        _accountAddress = session?.session.namespaces['eip155']?.accounts[0].substring(getPos(session?.session.namespaces['eip155']?.accounts[0], ':', 2) + 1);
        debugPrint("Account Address $_accountAddress");

        // launchUrlString(_appUri, mode: LaunchMode.externalApplication);

        await _signRequest(chain);
      });
    } catch (exp) {
      debugPrint("$exp");
    }
  } // Used to authenticate and sign with metamask

  _launchWithWalletConnect() async {
    try {
      await _getUri();
      _toggleModalVisibility();

      _session = await _response.session.future;
      debugPrint("Session $_session");
      _signClient.onSessionConnect.subscribe((SessionConnect? session) async {
        _toggleModalVisibility();

        var chain = session?.session.namespaces['eip155']?.accounts[0].substring(0, getPos(session?.session.namespaces['eip155']?.accounts[0], ':', 2));
        debugPrint("Chain $chain");
        _accountAddress =
            session?.session.namespaces['eip155']?.accounts[0].substring(getPos(session?.session.namespaces['eip155']?.accounts[0], ':', 2) + 1);
        debugPrint("Account Address $_accountAddress");

        await _signRequest(chain);
      });
    } catch (exp) {
      debugPrint("$exp");
    }
  } // Used to authenticate and sign with walletConnect

  _signRequest(chain) async {
    try {
      _signature = await _signClient.request(
        topic: _session.topic,
        chainId: chain,
        request: SessionRequestParams(method: 'personal_sign', params: [
          '5468697320697320666f7220766572696669636174696f6e',
          _accountAddress
        ]),
      );
      debugPrint("Signature $_signature");
    } catch (exp) {
      debugPrint("$exp");
    }
  } // Used to sign a message for verification

  @override
  void initState() {
    super.initState();
    _signInstanceCreate().then((_) {
      setState(() {
        _isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Stack(
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
                              ontap: () => _launchWithMetamask(),
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
                              ontap: () => _launchWithWalletConnect(),
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
            if (_isModalVisible)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: WalletConnectModal(
                    uri: _appUri,
                    launchWallet: _launchWithMetamask,
                    closeBehavior: _handleTap,
                  ),
                ),
              )
          ],
        ),
      );
    }
  }
}

// Future<void> _storeWalletAddress(String address, String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('wallet_address', address);
//   await prefs.setString('token', token);
// }
