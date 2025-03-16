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
                      "Say Hii.. ✌",
                      style: AppTextStyles.heading2,
                    ),
                  ),
                ),
              ),
              const ChatInputField(),
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

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});
  @override
  ChatInputFieldState createState() => ChatInputFieldState();
}

class ChatInputFieldState extends State<ChatInputField> {
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: IntrinsicHeight(
              // Ensures prefix and suffix stay aligned
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Aligns icons at bottom
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.r),
                      child: Icon(
                        Icons.emoji_emotions,
                        size: 28.sp,
                        color: AppColors.softWhite,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 160.h, // Limits expansion
                        ),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: TextField(
                              minLines: 1,
                              controller: messageController,
                              maxLines: null, // Allows multiline
                              onChanged: (value) {
                                setState(() {
                                  isEmpty = value.trim().isEmpty;
                                });
                              },
                              style: AppTextStyles.bodyText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Message...",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 12.h),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.r, horizontal: 8.w),
                      child: Icon(
                        Icons.attach_file,
                        size: 28.sp,
                        color: AppColors.softWhite,
                      ),
                    ),
                    isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.r, horizontal: 8.w),
                            child: Icon(
                              Icons.camera_alt,
                              size: 28.sp,
                              color: AppColors.softWhite,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.darkGreen,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              highlightColor: AppColors.darkGreenAccent,
              onPressed: () {},
              icon: Icon(
                isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
