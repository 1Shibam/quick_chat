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
            )),
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
