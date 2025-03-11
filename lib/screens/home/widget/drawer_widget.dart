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
            title: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  context.go(RouterNames.splash);
                },
                icon: const Icon(Icons.logout)),
          ),
        ],
      ),
    );
  }
}