// ignore_for_file: file_names

import 'package:bikeshop/Constants/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        elevation: 3,
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
        ),
      ),
    ),
  );
}
