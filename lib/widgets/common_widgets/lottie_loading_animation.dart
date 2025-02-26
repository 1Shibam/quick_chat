
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/theme/text_styles.dart';

class LottieLoadingAnimation extends StatelessWidget {
  final double opacity;
  final double? height;
  final double? width;
  const LottieLoadingAnimation({super.key, this.opacity = 1, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreen.withOpacity(opacity),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/fitness lottie json.json',
                height: height?.r ?? 300.r , width: width?.r ?? 300.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loading',
                  style: AppTextStyles.bodyText,
                ),
                AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText('....',
                      speed: const Duration(milliseconds: 500))
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
