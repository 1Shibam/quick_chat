import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/theme/fonts.dart';

class AppTextStyles {
  static TextStyle heading1 = TextStyle(
      fontSize: 32.sp, fontFamily: Fonts.boldFont, color: AppColors.softWhite);

  static TextStyle heading2 = TextStyle(
      fontSize: 24.sp, fontFamily: Fonts.boldFont, color: AppColors.softWhite);

  static TextStyle bodyText = TextStyle(
      fontSize: 18.sp,
      fontFamily: Fonts.regularFont,
      color: AppColors.softWhite);

  static TextStyle caption =
      TextStyle(fontSize: 14.sp, color: AppColors.softGrey);

  static TextStyle buttonText = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.softGrey);
}
