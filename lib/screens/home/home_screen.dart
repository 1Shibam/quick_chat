import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                const HomeScreenSearchBar(),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 4.h),

                              //leading icon for profile images
                              leading: CircleAvatar(
                                radius: 28.r,
                              ),

                              //title name of the user --
                              title: Text(
                                'UserName',
                                style: AppTextStyles.heading2,
                              ),

                              //last message sent as subtitle
                              subtitle: Text(
                                'bro were cooked',
                                style: AppTextStyles.caption,
                              ),

                              //last time of interaction or communication  --

                              trailing: Text(
                                DateTime.now()
                                    .toString()
                                    .split(' ')[1]
                                    .split('.')[0]
                                    .substring(0, 5),
                                style: AppTextStyles.buttonText,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        );
                      },
                      itemCount: 27,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

//Extracted the search bar -- search logic later
class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search Chat',
      hintStyle: WidgetStatePropertyAll(AppTextStyles.heading3),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Platform.isIOS ? CupertinoIcons.search : Icons.search_rounded,
            color: AppColors.softWhite,
            size: 28.sp,
          ),
          SizedBox(width: 8.w), // Spacing before the divider
          SizedBox(
              height: 24.h, // Ensure it has a height
              child: const VerticalDivider(
                color: AppColors.softWhite,
                thickness: 1.5,
                width: 1, // Controls the width of the empty space around it
              )),
        ],
      ),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r))),
      backgroundColor: const WidgetStatePropertyAll(AppColors.darkGreen),
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
          ),
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
