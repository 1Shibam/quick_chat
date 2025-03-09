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
              child: const HomeScreenAppBar()),
          drawer: const DrawerWidgetHomeScreen(),
          floatingActionButton: const FloadingActionButton(),
          body: Scrollbar(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SearchBar(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r))),
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.darkGreen),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                          leading: CircleAvatar(
                            radius: 32.r,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        )
                      ],
                    );
                  },
                  itemCount: 27,
                ),
              ),
            ],
          ))),
    );
  }
}

// Home screen App - Bar
class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text('QuickChat'),
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu,
                  size: 40.sp,
                  color: AppColors.softWhite,
                ));
          },
        ));
  }
}

//Home Screen drawer widget
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
          )
        ],
      ),
    );
  }
}

//Floating Action button will be displayed on home screen -- logic will be done later on
class FloadingActionButton extends StatelessWidget {
  const FloadingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.chat,
          color: AppColors.softGrey,
          size: 28.sp,
        ),
      ),
    );
  }
}
