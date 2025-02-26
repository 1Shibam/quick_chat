import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:quick_chat/router/router_names.dart';
import 'package:quick_chat/theme/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) context.go(RouterNames.home);
    });

    return Scaffold(
      body: Center(
        child: AnimatedTextKit(animatedTexts: [
          FlickerAnimatedText(' LOADING ...',
              textStyle: AppTextStyles.heading1)
        ]),
      ),
    );
  }
}
