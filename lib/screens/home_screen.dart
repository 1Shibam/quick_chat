import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/theme/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: AppBar(
              title: const Text('QuickChat'),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.chat,
            color: AppColors.softGrey,
            size: 28.sp,
          ),
        ),
        body: Center(
          child: Text(
            'This is home',
            style: AppTextStyles.heading1,
          ),
        ),
      ),
    );
  }
}
