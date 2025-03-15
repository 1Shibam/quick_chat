import 'package:cached_network_image/cached_network_image.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
    required this.filteredSearch,
  });

  final List<ChatUserModel> filteredSearch;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredSearch.length,
      itemBuilder: (context, index) {
        final singleUser = filteredSearch[index];

        return ListTile(
          leading: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: singleUser.profileUrl == ''
                    ? 'https://i.imgur.com/PcvwDlW.png'
                    : singleUser.profileUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.person),
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
