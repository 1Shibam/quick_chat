import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';

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
