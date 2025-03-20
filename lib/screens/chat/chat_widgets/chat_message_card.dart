import 'package:photo_view/photo_view.dart';
import 'package:quick_chat/Exports/common_exports.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.isImage,
    required this.isVideo,
    required this.isText,
    required this.messageTime,
    required this.isCurrentUser,
  });

  final String message;
  final String messageTime;
  final bool isCurrentUser;
  final bool isImage;
  final bool isVideo;
  final bool isText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Align(
        alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max, // ✅ Fixes the extra spacing issue
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCurrentUser) // ✅ Only adds the widget if it's needed
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Text(
                  getFormattedTime(context: context, time: messageTime)
                      .toString(),
                  style: AppTextStyles.buttonText,
                ),
              ),
            Flexible(
              child: Padding(
                padding: isCurrentUser
                    ? EdgeInsets.symmetric(vertical: 4.h).copyWith(left: 16.w)
                    : EdgeInsets.symmetric(vertical: 4.h).copyWith(right: 16.w),
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? AppColors.darkGreenAccent
                        : AppColors.darkGreen,
                    borderRadius: isCurrentUser
                        ? BorderRadius.circular(20.r)
                            .copyWith(topRight: const Radius.circular(0))
                        : BorderRadius.circular(20.r)
                            .copyWith(topLeft: const Radius.circular(0)),
                  ),
                  child: isText
                      ? Text(
                          message,
                          style: AppTextStyles.buttonText,
                        )
                      : isImage
                          ? PhotoView(imageProvider: null)
                          : isVideo
                              ? const SizedBox()
                              : const SizedBox(),
                ),
              ),
            ),
            if (!isCurrentUser) // ✅ Only adds the widget if it's needed
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  getFormattedTime(context: context, time: messageTime)
                      .toString(),
                  style: AppTextStyles.buttonText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

String getFormattedTime({required BuildContext context, required String time}) {
  final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  return TimeOfDay.fromDateTime(date).format(context);
}
