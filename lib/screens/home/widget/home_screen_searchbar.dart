//Extracted the search bar -- search logic later
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quick_chat/Exports/common_exports.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search Chat',
      hintStyle: WidgetStatePropertyAll(AppTextStyles.heading3),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Platform.isIOS ? CupertinoIcons.search : Icons.search_rounded,
            color: AppColors.softWhite,
            size: 28.sp,
          ),
          SizedBox(width: 8.w), // Spacing before the divider
          SizedBox(
              height: 24.h, // Ensure it has a height
              child: const VerticalDivider(
                color: AppColors.softWhite,
                thickness: 1.5,
                width: 1, // Controls the width of the empty space around it
              )),
        ],
      ),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r))),
      backgroundColor: const WidgetStatePropertyAll(AppColors.darkGreen),
    );
  }
}
