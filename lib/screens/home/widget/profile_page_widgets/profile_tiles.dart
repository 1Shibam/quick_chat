import 'package:quick_chat/Exports/common_exports.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      required this.title,
      required this.value,
      this.onPressed,
      this.isEmail = false});
  final String title;
  final String value;
  final VoidCallback? onPressed;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        tileColor: AppColors.darkGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(title, style: AppTextStyles.heading2),
        subtitle: Text(value == '' ? 'not Mentinoned' : value,
            style: value == ''
                ? AppTextStyles.bodyText.copyWith(color: AppColors.grey)
                : AppTextStyles.bodyText),
        trailing: isEmail
            ? null
            : IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                  size: 28.sp,
                  color: AppColors.softWhite,
                )),
      ),
    );
  }
}
