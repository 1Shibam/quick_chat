import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.userInfo});
  final ChatUserModel userInfo;

  @override
  Widget build(BuildContext context) {
    const String emptyProfile = 'https://i.imgur.com/PcvwDlW.png';
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 64.h),
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(color: AppColors.darkGreen),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Platform.isIOS
                                  ? CupertinoIcons.back
                                  : Icons.arrow_back,
                              color: AppColors.softWhite,
                              size: 32.sp,
                            ),
                            CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                    imageUrl: userInfo.profileUrl == ''
                                        ? emptyProfile
                                        : userInfo.profileUrl),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                      flex: 4,
                      child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            height: double.infinity,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                userInfo.username,
                                style: AppTextStyles.heading3,
                              ),
                            ),
                          ))),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Platform.isIOS ? CupertinoIcons.phone : Icons.phone,
                          color: AppColors.softWhite,
                          size: 32.sp,
                        ),
                        Icon(
                          Platform.isIOS
                              ? Icons.more_vert
                              : CupertinoIcons.ellipsis_vertical,
                          size: 32.sp,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
