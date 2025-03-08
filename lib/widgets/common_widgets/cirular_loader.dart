import 'package:quick_chat/Exports/common_exports.dart';

Future<dynamic> ciruclarLoader(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.softGrey,
        ),
      );
    },
  );
}
