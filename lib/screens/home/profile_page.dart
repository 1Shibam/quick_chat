import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/providers/user_provider.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/all_profile_tile.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/profile_image_section.dart';

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

                // when data is available
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
                          //Image and and image edit section --
                          ProfileImageSection(userData: userData),
                          SizedBox(
                            height: 2.h,
                          ),
                          //joined date -
                          Text(
                            'Joined At: ${userData.createdAt.split('T')[0]}',
                            style: AppTextStyles.bodyText,
                          ),
                          // online status --
                          Text(
                            userData.isOnline ? 'Online' : 'Offline',
                            style: AppTextStyles.bodyText,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          //profile details tiles- name , username etc..
                          AllProfileTiles(userData: userData)
                        ],
                      ),
                    ),
                  );
                },

                //Errror state -
                error: (error, stackTrace) => Center(
                      child: Text(
                        'Something went wrong',
                        style: AppTextStyles.heading2,
                      ),
                    ),

                //loading state -
                loading: () => const CircularProgressIndicator());
          },
        ));
  }
}
