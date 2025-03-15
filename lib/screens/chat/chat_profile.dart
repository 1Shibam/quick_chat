import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/profile_tiles.dart';

class ChatProfile extends StatelessWidget {
  const ChatProfile({super.key, required this.chatUserDetail});
  final ChatUserModel chatUserDetail;

  @override
  Widget build(BuildContext context) {
    const String emptyProfile = 'https://i.imgur.com/PcvwDlW.png';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.clear,
              size: 40.sp,
              color: AppColors.softWhite,
            )),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              CircleAvatar(
                radius: 100.r,
                backgroundImage: CachedNetworkImageProvider(
                    chatUserDetail.profileUrl == ''
                        ? emptyProfile
                        : chatUserDetail.profileUrl),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Joined At: ${chatUserDetail.createdAt.split('T')[0]}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                ' ${chatUserDetail.isOnline == true ? 'Online' : 'Offline'}',
                style: AppTextStyles.bodyText,
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ProfileTile(
                    title: 'Username',
                    value: chatUserDetail.username,
                    disableEditing: true,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
