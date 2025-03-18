import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/message_model.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/messages_provider.dart';
import 'package:quick_chat/screens/chat/chat_profile.dart';
import 'package:quick_chat/screens/chat/chat_widgets/chat_input_field.dart';
import 'package:quick_chat/screens/chat/chat_widgets/chat_message_card.dart';
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
              SizedBox(
                height: 40.h,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final messageStream = ref.watch(messageProvider(userInfo));

                  return messageStream.when(
                      data: (snapshot) {
                        final messages = snapshot.docs
                            .map((doc) => MessageModel.fromJson(doc.data()))
                            .toList();
                        if (messages.isEmpty) {
                          return const Expanded(
                            child: Center(
                              child: Text('Say hi !✌✌'),
                            ),
                          );
                        }
                        return Expanded(
                            child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final singleMessage = messages[index];
                            return userInfo.userID == singleMessage.senderID
                                ? MessageCard(
                                    message: singleMessage.message,
                                    isCurrentUser: false,
                                    messageTime: singleMessage.sentTime,
                                    isImage: false,
                                    isVideo: false,
                                    isText: true)
                                : MessageCard(
                                    message: singleMessage.message,
                                    isCurrentUser: true,
                                    messageTime: singleMessage.sentTime,
                                    isImage: false,
                                    isVideo: false,
                                    isText: true);
                          },
                        ));
                      },
                      error: (error, stackTrace) {
                        return const Center(
                          child: Text('lmao tf you doing'),
                        );
                      },
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ));
                },
              ),

              //Chat input field
              ChatInputField(
                userInfo: userInfo,
              ),
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





