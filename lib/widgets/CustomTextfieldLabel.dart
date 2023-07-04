import 'package:flutter/material.dart';

import 'package:cratch/Utils/app_style.dart';
import 'package:cratch/widgets/customtext.dart';

class CustomTextfieldLabel extends StatelessWidget {
  String title;

  CustomTextfieldLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );

    // CustomText(

    //     textStyle: AppStyle.textStyle14whiteSemiBold, title: title);
  }
}
