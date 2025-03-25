import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/messages_provider.dart';
import 'package:quick_chat/screens/chat/chat_screen.dart';
import 'package:quick_chat/widgets/chat_wdgets/full_screen_image.dart';

class UsersList extends ConsumerWidget {
  const UsersList(
      {super.key, required this.filteredSearch, required this.lastMessage});

  final List<ChatUserModel> filteredSearch;
  final String lastMessage;

  @override
  Widget build(BuildContext context, ref) {
    const String emptyProfile = 'https://i.imgur.com/PcvwDlW.png';
    return ListView.builder(
      itemCount: filteredSearch.length,
      itemBuilder: (context, index) {
        final singleUser = filteredSearch[index];

        return ChatTileWidget(singleUser: singleUser, emptyProfile: emptyProfile);
      },
    );
  }
}

class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget({
    super.key,
    required this.singleUser,
    required this.emptyProfile,
  });

  final ChatUserModel singleUser;
  final String emptyProfile;

  @override
  Widget build(BuildContext context) {
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
      subtitle: Consumer(
        builder: (context, ref, child) {
          final lastMessage =
              ref.watch(lastMessageProvider(singleUser.userID));
    
          return lastMessage.when(
            data: (message) {
              if (message == null) {
                return Text(
                  singleUser.bio,
                  style: AppTextStyles.caption,
                );
              }
    
              return Text(
                message.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) =>
                const Text("Error loading message"),
          );
        },
      ),
    );
  }
}
