import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/profile_tiles.dart';
import 'package:quick_chat/widgets/chat_wdgets/full_screen_image.dart';

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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                        imageUrl: chatUserDetail.profileUrl.isNotEmpty
                            ? chatUserDetail.profileUrl
                            : emptyProfile,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 100.r,
                  backgroundImage: CachedNetworkImageProvider(
                      chatUserDetail.profileUrl == ''
                          ? emptyProfile
                          : chatUserDetail.profileUrl),
                ),
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
                  ),
                  ProfileTile(
                    title: 'Full name',
                    value: chatUserDetail.fullName,
                    disableEditing: true,
                  ),
                  ProfileTile(
                    title: 'Email',
                    value: chatUserDetail.email,
                    disableEditing: true,
                  ),
                  ProfileTile(
                    title: 'Bio',
                    value: chatUserDetail.bio,
                    disableEditing: true,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
