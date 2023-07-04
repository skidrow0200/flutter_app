import 'package:flutter/material.dart';
import 'package:cratch/Utils/color_constant.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({Key? key, this.appbar, this.body}) : super(key: key);

  PreferredSizeWidget? appbar;
  Widget? body;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.center,
                colors: [
              AppColors.bgGradient1,
              AppColors.bgGradient1,
              AppColors.bgGradient2,
              AppColors.bgGradient2,
              AppColors.bgGradient1,
              AppColors.bgGradient1,
            ])),
        child: Scaffold(
          backgroundColor: AppColors.bgGradient2.withOpacity(0.6),
          appBar: appbar,
          body: body,
        ));
  }
}
