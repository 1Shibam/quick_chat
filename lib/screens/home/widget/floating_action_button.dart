import 'package:quick_chat/Exports/common_exports.dart';

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
