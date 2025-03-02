import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBlack,
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LottieLoadingAnimation();
            }
            final user = snapshot.data;

            // After 2 seconds, navigate to the correct screen
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                if (user != null && user.emailVerified) {
                  context.go(RouterNames.home);
                } else {
                  context.go(RouterNames.login);
                }
              }
            });

            return const LottieLoadingAnimation(); // Keep showing animation until navigation happens
          },
        ),
      ),
    );
  }
}
