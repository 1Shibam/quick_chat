import 'package:quick_chat/Exports/common_exports.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.w),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircleAvatar()],
        ),
      ),
    );
  }
}
