import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/screens/chat/chat_profile.dart';
import 'package:quick_chat/widgets/chat_wdgets/full_screen_image.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.userInfo});
  final ChatUserModel userInfo;

  @override
  Widget build(BuildContext context) {
    const String emptyProfile = 'https://i.imgur.com/PcvwDlW.png';

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 64.h),
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: const BoxDecoration(color: AppColors.darkGreen),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
                      color: AppColors.softWhite,
                      size: 28.sp,
                    ),
                  ),
                  // Profile Image
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrl: userInfo.profileUrl.isEmpty
                                ? emptyProfile
                                : userInfo.profileUrl,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 21.r,
                      backgroundImage: CachedNetworkImageProvider(
                        userInfo.profileUrl.isEmpty
                            ? emptyProfile
                            : userInfo.profileUrl,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Username
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatProfile(chatUserDetail: userInfo),
                          ),
                        );
                      },
                      child: Text(
                        userInfo.username,
                        style: AppTextStyles.heading3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Action Buttons (Call & More)
                  Row(
                    children: [
                      Icon(
                        Platform.isIOS ? CupertinoIcons.phone : Icons.phone,
                        color: AppColors.softWhite,
                        size: 28.sp,
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Platform.isIOS
                            ? CupertinoIcons.ellipsis_vertical
                            : Icons.more_vert,
                        color: AppColors.softWhite,
                        size: 28.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.greyBlack,
                  child: Center(
                    child: Text(
                      "Chat messages will appear here",
                      style: AppTextStyles.bodyText
                          .copyWith(color: Colors.white60),
                    ),
                  ),
                ),
              ),
              const BuildMessageInput(),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildMessageInput extends StatefulWidget {
  const BuildMessageInput({super.key});

  @override
  State<BuildMessageInput> createState() => _BuildMessageInputState();
}

class _BuildMessageInputState extends State<BuildMessageInput> {
  final TextEditingController messageController = TextEditingController();
  bool isEmpty = true;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      color: AppColors.greyBlack,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    isEmpty = true;
                  });
                } else {
                  setState(() {
                    isEmpty = false;
                  });
                }
              },
              style: AppTextStyles.bodyText,
              decoration: InputDecoration(
                fillColor: AppColors.darkGreen,
                filled: true,
                prefixIcon: Icon(
                  Icons.emoji_emotions,
                  size: 28.sp,
                  color: AppColors.softWhite,
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 28.sp,
                        color: AppColors.softWhite,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 28.sp,
                        color: AppColors.softWhite,
                      )
                    ],
                  ),
                ),
                hintText: "Type a message...",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            decoration: BoxDecoration(
              color: AppColors.darkGreen, // Background color
              shape: BoxShape.circle, // Makes it circular
            ),
            child: IconButton(
              highlightColor: AppColors.darkGreenAccent,
              onPressed: () {},
              icon: Icon(
                isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
