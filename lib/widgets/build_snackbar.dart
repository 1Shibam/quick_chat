import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/theme/text_styles.dart';

void buildSnackBar(BuildContext context, String yapp,
    {Color? bgColor, int? sec, bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      yapp,
      style: AppTextStyles.bodyText,
    ),
    backgroundColor: bgColor ?? AppColors.grey,
    duration: Duration(seconds: sec ?? 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
  ));
}
