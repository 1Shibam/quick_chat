import 'package:quick_chat/Exports/common_exports.dart';

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
      body: Padding(
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
                    ),
                  ),
                  Positioned(
                    bottom: 8.h,
                    right: 2.w,
                    child: GestureDetector(
                      onTap: () {
                        //Update profile logic --
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
                'Joined At: blah-blah',
                style: AppTextStyles.bodyText,
              ),
              SizedBox(
                height: 16.h,
              ),
              ProfileTiles(title: 'Username', value: 'johndoe123'),
              ProfileTiles(title: 'Name', value: 'John Doe'),
              ProfileTiles(
                title: 'Status',
                value: 'Offline',
              ),
              ProfileTiles(
                  title: 'Bio', value: 'Flutter enthusiast & Developer'),
              ProfileTiles(title: 'Email', value: 'johndoe@email.com'),
            ],
          ),
        ),
      ),
    );
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
