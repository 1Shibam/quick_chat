import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return; // Ensure widget is still in the tree before navigating
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      context.go(RouterNames.home);
    } else {
      context.go(RouterNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingAnimation(),
          );
        }
        final user = snapshot.data;
        if (user != null && user.emailVerified) {
          Future.microtask(() async {
            if (context.mounted) {
              context.go(RouterNames.home);
            }
          });
        } else {
          Future.microtask(() {
            if (context.mounted) {
              context.go(RouterNames.login);
            }
          });
        }
        return const Center(
          child: LoadingAnimation(),
        );
      },
    ));
  }
}
