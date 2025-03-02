import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_chat/theme/text_styles.dart';

class LottieLoadingAnimation extends StatelessWidget {
  final double opacity;
  final double? height;
  final double? width;
  const LottieLoadingAnimation(
      {super.key, this.opacity = 1, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/chat loading.svg',
              width: 200.w,
              height: 200.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loading',
                  style: AppTextStyles.heading2,
                ),
                AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText('....',
                      textStyle: AppTextStyles.heading2,
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
