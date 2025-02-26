import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_chat/screens/home_screen.dart';
import 'package:quick_chat/screens/splash_screen.dart';

GoRouter router = GoRouter(initialLocation: '/',routes: [
  splashScreenRoute(),
]);

GoRoute splashScreenRoute() {
  return GoRoute(
path: '/',
pageBuilder: (context, state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: const SplashScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity:
            CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
},
);
}
GoRoute homeScreenRoute() {
  return GoRoute(
path: '/home',
pageBuilder: (context, state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: const HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity:
            CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
},
);
}
