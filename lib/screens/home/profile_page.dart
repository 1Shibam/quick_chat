import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';
import 'package:quick_chat/providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.clear,
                size: 40.sp,
                color: AppColors.softWhite,
              )),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final userData = ref.watch(userProvider).value!.first;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: CircleAvatar(
                            backgroundColor: AppColors.darkGreen,
                            radius: 80.r,
                            child: CachedNetworkImage(
                                imageUrl: userData.profileUrl),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: () async {
                              //Update profile logic --
                              await ref
                                  .read(firestoreServiceStateNotifierProvider
                                      .notifier)
                                  .changeProfilePicture(context,
                                      userData.userID, ImageSource.camera);

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.camera_alt_rounded,
                                                size: 40.sp,
                                                color: AppColors.softGrey,
                                              ),
                                              Text(
                                                'Camera',
                                                style: AppTextStyles.heading2,
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 40.sp,
                                                color: AppColors.softGrey,
                                              ),
                                              Text(
                                                'Gallery',
                                                style: AppTextStyles.heading2,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
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
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Joined At: ${userData.createdAt}',
                      style: AppTextStyles.bodyText,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ProfileTiles(title: 'Username', value: userData.username),
                    ProfileTiles(title: 'Name', value: userData.fullName),
                    ProfileTiles(
                      title: 'Status',
                      value: userData.isOnline ? 'Online' : 'Offline',
                    ),
                    ProfileTiles(title: 'Bio', value: userData.bio),
                    ProfileTiles(title: 'Email', value: userData.email),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUnfocus,
        initialValue: value,
        style: AppTextStyles.bodyText,
        decoration: InputDecoration(labelText: title),
      ),
    );
  }
}
