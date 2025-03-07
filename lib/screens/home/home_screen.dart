import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/Exports/common_exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: AppBar(
                title: const Text('QuickChat'),
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(Icons.menu));
                  },
                ))),
        drawer: Drawer(
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
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(8.w),
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.chat,
              color: AppColors.softGrey,
              size: 28.sp,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'This is home',
            style: AppTextStyles.heading1,
          ),
        ),
      ),
    );
  }
}
