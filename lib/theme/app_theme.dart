
import 'package:quick_chat/Exports/common_exports.dart';

ThemeData quickChatTheme() {
    return ThemeData(
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
          );
  }