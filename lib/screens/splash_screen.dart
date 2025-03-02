import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_chat/router/router_names.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/widgets/common_widgets/lottie_loading_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) context.go(RouterNames.login);
      //decide where to go if the user is logged in than go to home else login -
    });
    return const Scaffold(
      backgroundColor: AppColors.greyBlack,
      body: Center(
        child: LottieLoadingAnimation(),
      ),
    );
  }
}
