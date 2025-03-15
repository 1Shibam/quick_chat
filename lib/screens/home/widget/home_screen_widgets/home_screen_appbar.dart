// Home screen App - Bar
import 'package:quick_chat/Exports/common_exports.dart';

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