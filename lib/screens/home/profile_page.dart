import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
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
                          child: ImageSelectionOptionWidget(userData: userData),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Joined At: ${userData.createdAt.split('T')[0]}',
                      style: AppTextStyles.bodyText,
                    ),
                    Text(
                      userData.isOnline ? 'Online' : 'Offline',
                      style: AppTextStyles.bodyText,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ProfileTiles(
                      title: 'Username',
                      value: userData.username,
                      onPressed: () {},
                    ),
                    ProfileTiles(
                      title: 'Email',
                      value: userData.email,
                      onPressed: () {},
                    ),
                    ProfileTiles(
                      title: 'Full Name',
                      value: userData.fullName,
                      onPressed: () {},
                    ),
                    ProfileTiles(
                      title: 'Bio',
                      value: userData.bio,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDetailUpdateDialog(
                              userId: userData.userID,
                              initialVal: userData.bio,
                              title: 'Bio',
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

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

class ProfileTiles extends StatelessWidget {
  const ProfileTiles(
      {super.key,
      required this.title,
      required this.value,
      required this.onPressed});
  final String title;
  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        tileColor: AppColors.darkGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(title, style: AppTextStyles.heading2),
        subtitle: Text(value == '' ? 'not Mentinoned' : value,
            style: AppTextStyles.bodyText),
        trailing: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.edit,
              size: 28.sp,
              color: AppColors.softWhite,
            )),
      ),
    );
  }
}

class ShowDetailUpdateDialog extends StatefulWidget {
  const ShowDetailUpdateDialog(
      {super.key,
      required this.initialVal,
      required this.title,
      required this.userId});
  final String userId;
  final String initialVal;
  final String title;

  @override
  State<ShowDetailUpdateDialog> createState() => _ShowDetailUpdateDialogState();
}

class _ShowDetailUpdateDialogState extends State<ShowDetailUpdateDialog> {
  late TextEditingController updateController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    updateController = TextEditingController(text: widget.initialVal);
  }

  @override
  void dispose() {
    updateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        backgroundColor: AppColors.darkGreen,
        title: Text('Update ${widget.title}', style: AppTextStyles.heading1),
        content: TextFormField(
          controller: updateController,
          decoration: InputDecoration(
            hintText: 'Enter new ${widget.title.toLowerCase()}',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: Text(
              'Cancel',
              style: AppTextStyles.buttonText,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () async {
                  await ref
                      .read(firestoreServiceStateNotifierProvider.notifier)
                      .changeBio(context, widget.userId, updateController.text);
                  if (context.mounted) {
                    context.pop();
                  }
                },
                child: Text(
                  'Update',
                  style: AppTextStyles.buttonText,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
