// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';
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
            final userAsync = ref.watch(currentUserProvider);

            return userAsync.when(
                data: (data) {
                  final userData = data;
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
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
                                      imageUrl: userData.profileUrl != ''
                                          ? userData.profileUrl
                                          : 'https://i.imgur.com/PcvwDlW.png'),
                                ),
                              ),
                              Positioned(
                                bottom: 8.h,
                                right: 2.w,
                                child: ImageSelectionOptionWidget(
                                    userData: userData),
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ShowDetailUpdateDialog(
                                    userId: userData.userID,
                                    initialVal: userData.username,
                                    title: 'User Name',
                                    updateField: UpdateFields.username,
                                  );
                                },
                              );
                            },
                          ),
                          ProfileTiles(
                            title: 'Email',
                            isEmail: true,
                            value: obscureEmail(userData.email),
                          ),
                          ProfileTiles(
                            title: 'Full Name',
                            value: userData.fullName,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ShowDetailUpdateDialog(
                                    userId: userData.userID,
                                    initialVal: userData.fullName,
                                    title: ' Name',
                                    updateField: UpdateFields.fullName,
                                  );
                                },
                              );
                            },
                          ),
                          ProfileTiles(
                            title: 'Bio',
                            value: userData.bio,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ShowDetailUpdateDialog(
                                    isBio: true,
                                    userId: userData.userID,
                                    initialVal: userData.bio,
                                    title: 'Bio',
                                    updateField: UpdateFields.bio,
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
                error: (error, stackTrace) => Center(
                      child: Text(
                        'Something went wrong',
                        style: AppTextStyles.heading2,
                      ),
                    ),
                loading: () => const CircularProgressIndicator());
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
                          Navigator.pop(context);
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
                          Navigator.pop(context);
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
      this.onPressed,
      this.isEmail = false});
  final String title;
  final String value;
  final VoidCallback? onPressed;
  final bool isEmail;

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
            style: value == ''
                ? AppTextStyles.bodyText.copyWith(color: AppColors.grey)
                : AppTextStyles.bodyText),
        trailing: isEmail
            ? null
            : IconButton(
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

enum UpdateFields { bio, username, fullName }

class ShowDetailUpdateDialog extends StatefulWidget {
  const ShowDetailUpdateDialog(
      {super.key,
      required this.initialVal,
      required this.title,
      required this.userId,
      required this.updateField,
      this.isBio = false});
  final String userId;
  final String initialVal;
  final String title;
  final UpdateFields updateField;
  final bool isBio;

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

  Future<void> onSubmit({required WidgetRef ref}) async {
    final String newVal = updateController.text.trim();
    if (formKey.currentState!.validate()) {
      if (newVal == widget.initialVal) {
        //if no changes are made
        context.pop();
        return;
      }
      switch (widget.updateField) {
        case UpdateFields.bio:
          await ref
              .read(firestoreServiceStateNotifierProvider.notifier)
              .changeBio(context, widget.userId, newVal);
          break;
        case UpdateFields.username:
          await ref
              .read(firestoreServiceStateNotifierProvider.notifier)
              .changeUserName(context, widget.userId, newVal);
          break;

        case UpdateFields.fullName:
          await ref
              .read(firestoreServiceStateNotifierProvider.notifier)
              .changeFullName(context, widget.userId, newVal);
          break;

        default:
          buildSnackBar(context, 'bro tf you on');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        backgroundColor: AppColors.darkGreen,
        title: Text('Update ${widget.title}', style: AppTextStyles.heading2),
        content: TextFormField(
          style: AppTextStyles.bodyText,
          maxLength: widget.isBio ? 50 : 16,
          maxLines: widget.isBio ? 3 : 1,
          validator: (value) {
            if (value == null || value.trim() == '') {
              return '${widget.title} can\'t be empty';
            } else {
              return null;
            }
          },
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
                  onSubmit(ref: ref);
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

//method for obscuring email -

String obscureEmail(String email) {
  List<String> parts = email.split('@');
  if (parts.length != 2) return email;
  String name = parts[0];
  String domain = parts[1];
  String obscuredName = name.substring(0, 2) + '*' * (name.length - 1);
  return "$obscuredName@$domain";
}
