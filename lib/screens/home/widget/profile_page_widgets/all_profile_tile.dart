import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/profile_tiles.dart';
import 'package:quick_chat/screens/home/widget/profile_page_widgets/show_detail_update_dialog.dart';

class AllProfileTiles extends StatelessWidget {
  const AllProfileTiles({
    super.key,
    required this.userData,
  });

  final ChatUserModel userData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ProfileTile(
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
          ProfileTile(
            title: 'Email',
            disableEditing: true,
            value: obscureEmail(userData.email),
          ),
          ProfileTile(
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
          ProfileTile(
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
