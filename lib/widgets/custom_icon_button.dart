import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  double? height;
  double? width;
  Widget? widget;
  Function() ontap;
  Gradient? gradient;
  Color? containerColor;
  List<BoxShadow>? boxShadow;

  IconButtonWidget(
      {Key? key,
      this.width,
      this.height,
      this.boxShadow,
      this.gradient,
      this.containerColor,
      this.widget,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradient,
          color: containerColor,
          boxShadow: boxShadow
        ),
        child: Center(child: widget),
      ),
    );
  }
}
