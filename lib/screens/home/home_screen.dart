import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/screens/home/widget/drawer_widget.dart';
import 'package:quick_chat/screens/home/widget/floating_action_button.dart';
import 'package:quick_chat/screens/home/widget/home_screen_appbar.dart';
import 'package:quick_chat/screens/home/widget/home_screen_searchbar.dart';
import 'package:quick_chat/services/firestore_services.dart';

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
          body: Column(
            children: [
              const HomeScreenSearchBar(),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                child: Scrollbar(child: Consumer(
                  builder: (context, ref, child) {
                    final user = ref.watch(userProvider);
                    return user.when(data: (user) {
                      if (user.isEmpty) {
                        return const Center(
                          child: Text('no users available'),
                        );
                      }
                      return ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          final singleUser = user[index];

                          return ListTile(
                            leading: CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: CachedNetworkImage(
                                  imageUrl: singleUser.profileUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.person),
                                ),
                              ),
                            ),
                            title: Text(
                              singleUser.username,
                              style: AppTextStyles.heading2,
                            ),
                          );
                        },
                      );
                    }, error: (error, stackTrace) {
                      debugPrint('Firestore Stream Error: $error');
                      debugPrintStack(stackTrace: stackTrace);
                      return const Text('Something went wrong');
                    }, loading: () {
                      return const CircularProgressIndicator();
                    });
                  },
                )),
              ),
            ],
          )),
    );
  }
}
