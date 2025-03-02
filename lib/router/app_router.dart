import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_chat/screens/auth/login_screen.dart';
import 'package:quick_chat/screens/auth/sign_up_screen.dart';
import 'package:quick_chat/screens/home_screen.dart';
import 'package:quick_chat/screens/splash_screen.dart';

GoRouter router = GoRouter(initialLocation: '/', routes: [
  splashScreenRoute(),
  homeScreenRoute(),
  loginScreenRoute(),
  signupScreenRoute()
]);

GoRoute splashScreenRoute() {
  return GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
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
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
  );
}

GoRoute loginScreenRoute() {
  return GoRoute(
    path: '/login',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
  );
}

GoRoute signupScreenRoute() {
  return GoRoute(
    path: '/signup',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const SignUpPage(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
  );
}
