import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/router/app_router.dart';
import 'firebase_options.dart';

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
                  titleTextStyle: AppTextStyles.heading1),
              inputDecorationTheme: InputDecorationTheme(
                  errorStyle: AppTextStyles.bodyText
                      .copyWith(color: AppColors.errorRedAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: AppColors.darkGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: AppColors.darkGreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: AppColors.softWhite),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: AppColors.errorRed),
                  )),
            ));
      },
    );
  }
}
