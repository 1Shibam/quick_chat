import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/theme/text_styles.dart';

class BuildPrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  const BuildPrimaryButton(
      {super.key,
      required this.text,
      this.color = AppColors.darkGreen,
      this.borderColor = AppColors.darkGreenAccent});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.heading2,
          ),
        ));
  }
}
