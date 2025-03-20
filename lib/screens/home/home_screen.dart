import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/providers/user_provider.dart';
import 'package:quick_chat/screens/home/widget/home_screen_widgets/drawer_widget.dart';
import 'package:quick_chat/screens/home/widget/home_screen_widgets/floating_action_button.dart';
import 'package:quick_chat/screens/home/widget/home_screen_widgets/home_screen_appbar.dart';
import 'package:quick_chat/screens/home/widget/home_screen_widgets/home_screen_searchbar.dart';
import 'package:quick_chat/screens/home/widget/home_screen_widgets/users_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
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
                      final user = ref.watch(otherUserProvider);
                      final searchQuery = ref.watch(searchQueryProvider);

                      return user.when(data: (userData) {
                        if (userData.isEmpty) {
                          return const Center(
                            child: Text('no users available'),
                          );
                        }
                        final filteredSearch = userData.where((user) {
                          return user.username
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase());
                        }).toList();
                        if (filteredSearch.isEmpty) {
                          return Center(
                            child: Text(
                              'No matching user found',
                              style: AppTextStyles.heading2,
                            ),
                          );
                        }
                        return UsersList(
                          filteredSearch: filteredSearch,
                          lastMessage: '',
                        );
                      },
                          //errro state if stream got some error --
                          error: (error, stackTrace) {
                        debugPrint('Firestore Stream Error: $error');
                        debugPrintStack(stackTrace: stackTrace);
                        return const Text('Something went wrong');
                      },
                          //loading state widget
                          loading: () {
                        return const Center(child: CircularProgressIndicator());
                      });
                    },
                  )),
                ),
              ],
            )),
      ),
    );
  }
}
