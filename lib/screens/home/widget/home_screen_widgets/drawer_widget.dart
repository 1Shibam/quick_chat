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
              onTap: () => context.push(RouterNames.profile),
              title: Text(
                'Profile',
                style: AppTextStyles.heading2,
              ),
              leading: const Icon(Icons.person)),
          ListTile(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.darkGreen,
                      title: Text('Logout !? ', style: AppTextStyles.heading2),
                      content: Text(
                        'Are you sure you want to logout?',
                        style: AppTextStyles.bodyText,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), // Cancel
                          child: Text(
                            'Cancel',
                            style: AppTextStyles.buttonText,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              context.go(RouterNames.splash);
                            }
                          },
                          child: Text(
                            'Yes',
                            style: AppTextStyles.buttonText,
                          ),
                        )
                      ],
                    );
                  });
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
