import 'package:flutter/material.dart';

import 'package:cratch/Utils/app_style.dart';
import 'package:cratch/widgets/customtext.dart';

class CustomLabel extends StatelessWidget {
  String title;

  CustomLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
        textStyle: AppStyle.textStyle14whiteSemiBold, title: title);
  }
}
