import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';

import '../../../../Exports/common_exports.dart';

class ImageSelectionOptionWidget extends ConsumerWidget {
  const ImageSelectionOptionWidget({
    super.key,
    required this.userData,
  });

  final ChatUserModel userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  side: const BorderSide(color: AppColors.softGrey)),
              title: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.softWhite,
                      size: 40.sp,
                    )),
              ),
              backgroundColor: AppColors.greyBlack.withOpacity(0.5),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(firestoreServiceStateNotifierProvider
                                  .notifier)
                              .changeProfilePicture(
                                  context, userData.userID, ImageSource.camera);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: 40.sp,
                          color: AppColors.softGrey,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: AppTextStyles.heading2,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(firestoreServiceStateNotifierProvider
                                  .notifier)
                              .changeProfilePicture(context, userData.userID,
                                  ImageSource.gallery);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.image,
                          size: 40.sp,
                          color: AppColors.softGrey,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: AppTextStyles.heading2,
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
            color: AppColors.softGrey,
            borderRadius: BorderRadius.circular(40.r)),
        child: const Icon(
          Icons.edit,
          color: AppColors.darkGreenAccent,
        ),
      ),
    );
  }
}
