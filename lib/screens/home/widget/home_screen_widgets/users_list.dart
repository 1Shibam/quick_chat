import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/screens/chat/chat_screen.dart';
import 'package:quick_chat/widgets/chat_wdgets/full_screen_image.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
    required this.filteredSearch,
  });

  final List<ChatUserModel> filteredSearch;

  @override
  Widget build(BuildContext context) {
    const String emptyProfile = 'https://i.imgur.com/PcvwDlW.png';
    return ListView.builder(
      itemCount: filteredSearch.length,
      itemBuilder: (context, index) {
        final singleUser = filteredSearch[index];

        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(userInfo: singleUser),
                ));
          },
          leading: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                        imageUrl: singleUser.profileUrl == ''
                            ? emptyProfile
                            : singleUser.profileUrl))),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                singleUser.profileUrl == ''
                    ? 'https://i.imgur.com/PcvwDlW.png'
                    : singleUser.profileUrl,
              ),
            ),
          ),
          title: Text(
            singleUser.username,
            style: AppTextStyles.heading3,
          ),
        );
      },
    );
  }
}
