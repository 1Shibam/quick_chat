import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/image_source_selection_widget.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({
    super.key,
    required this.userData,
  });

  final ChatUserModel userData;

  @override
  Widget build(BuildContext context) {
    const String emptyProfile = 'https://i.imgur.com/PcvwDlW.png';
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: CircleAvatar(
            backgroundColor: AppColors.darkGreen,
            radius: 80.r,
            child: CachedNetworkImage(
                imageUrl: userData.profileUrl != ''
                    ? userData.profileUrl
                    : emptyProfile),
          ),
        ),
        Positioned(
          bottom: 8.h,
          right: 2.w,
          child: ImageSelectionOptionWidget(userData: userData),
        )
      ],
    );
  }
}
