import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cratch/Utils/app_style.dart';
import 'package:cratch/Utils/color_constant.dart';
import 'package:cratch/widgets/Sizebox/sizedboxheight.dart';

class CustomTextFormField extends StatefulWidget {
  final String? title;
  final String? star;
  final String? hintText;
  final bool isEdit;
  const CustomTextFormField(
      {this.title, this.star, this.hintText, required this.isEdit});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isTapped = false;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text: widget.title,
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: ' ${widget.star}',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        CustomSizedBoxHeight(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: TextFormField(
            enabled: widget.isEdit,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: AppStyle.textStyle12Regular,
                filled: true,
                fillColor: isTapped
                    ? AppColors.textFieldActive.withOpacity(0.2)
                    : AppColors.fieldUnActive,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.redAccsent))),
            onTap: () {
              setState(() {
                isTapped = true;
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                isTapped = false;
              });
            },
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  isTapped = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}

class DropDown extends StatefulWidget {
  final String category;
  DropDown({required this.category});
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final List<String> dropdownItems = [
    'Crypto',
    'Gaming',
    'Play 2 Earn',
    'Lifestyle',
    'Educational',
    'Sports',
    'Travel & Events',
    'Film & Animation',
    'People & Blogs'
  ];
  String dropdownValue = "Crypto";

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.category.isEmpty ? "Crypto" : widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: BoxDecoration(
          color: AppColors.fieldUnActive,
          borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: DropdownButton<String>(
          dropdownColor: Color.fromRGBO(52, 53, 65, 1),
          hint: Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Text(
              'Enter here',
              style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          underline: Container(),
          isExpanded: true,
          isDense: true,
          focusColor: Colors.white,
          borderRadius: BorderRadius.circular(6),
          icon:
              Icon(Icons.arrow_drop_down_outlined, color: AppColors.whiteA700),
          value: dropdownValue,
          items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
