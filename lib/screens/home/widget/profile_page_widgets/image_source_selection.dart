import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';

class ImageSourceOptions extends StatelessWidget {
  const ImageSourceOptions({super.key, required this.userData});
  final ChatUserModel userData;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          height: 200.h,
          decoration: BoxDecoration(
              color: AppColors.darkGreen,
              borderRadius: BorderRadius.circular(20.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Source',
                  style: AppTextStyles.heading1,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
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
                                .changeProfilePicture(context, userData.userID,
                                    ImageSource.camera);
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
              ],
            ),
          ),
        );
      },
    );
  }
}
