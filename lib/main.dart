import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_chat/router/app_router.dart';
import 'package:quick_chat/theme/app_colors.dart';

import 'firebase_options.dart';
import 'theme/text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const ProviderScope(child: QuickChatApp()));
}

class QuickChatApp extends StatelessWidget {
  const QuickChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Quick Chat',
          routerConfig: router,
          theme: ThemeData(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                splashColor: AppColors.grey,
                backgroundColor: AppColors.darkGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r)),
              ),
              scaffoldBackgroundColor: AppColors.greyBlack,
              appBarTheme: AppBarTheme(
                  color: Colors.transparent,
                  centerTitle: false,
                  titleTextStyle: AppTextStyles.heading1)),
        );
      },
    );
  }
}
