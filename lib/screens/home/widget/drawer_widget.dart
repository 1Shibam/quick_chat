//Home Screen drawer widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/Exports/common_exports.dart';

class DrawerWidgetHomeScreen extends StatelessWidget {
  const DrawerWidgetHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkGreen,
      child: ListView(
        children: [
          DrawerHeader(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Menu',
                  style: AppTextStyles.heading1,
                )),
          ),
          ListTile(
              title: Text(
                'Profile',
                style: AppTextStyles.heading2,
              ),
              leading: const Icon(Icons.person)),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(RouterNames.splash);
            },
            title: Text(
              'Log Out',
              style: AppTextStyles.heading2,
            ),
            leading: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
