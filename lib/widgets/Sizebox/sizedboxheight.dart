import 'package:flutter/material.dart';

class CustomSizedBoxHeight extends StatelessWidget {
  double height ;
  CustomSizedBoxHeight({required this.height,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }
}
