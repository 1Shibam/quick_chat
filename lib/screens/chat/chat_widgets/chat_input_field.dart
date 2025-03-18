import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key, required this.userInfo});
  final ChatUserModel userInfo;
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
              child: isEmpty
                  ? IconButton(
                      highlightColor: AppColors.darkGreenAccent,
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 28.sp,
                      ),
                    )
                  : Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          highlightColor: AppColors.darkGreenAccent,
                          onPressed: () {
                            ref
                                .read(firestoreServiceStateNotifierProvider
                                    .notifier)
                                .sendMessageToUsers(
                                    context: context,
                                    message: messageController.text,
                                    chatUser: widget.userInfo);
                            messageController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }
}