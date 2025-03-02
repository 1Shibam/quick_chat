import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/theme/text_styles.dart';

class BottomRichTextWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String pageName;
  const BottomRichTextWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.pageName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: AppTextStyles.bodyText,
        children: [
          TextSpan(
            text: text2,
            style: AppTextStyles.bodyText
                .copyWith(color: AppColors.darkGreenAccent),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.go(pageName),
          ),
        ],
      ),
    );
  }
}