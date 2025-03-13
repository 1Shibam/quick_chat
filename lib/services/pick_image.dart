import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/widgets/common_widgets/build_snackbar.dart';

Future<File?> pickImage(ImageSource source, BuildContext context) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  } catch (e) {
    if (context.mounted) {
      buildSnackBar(context, 'Process Cancelled', bgColor: AppColors.errorRed);
    }
    rethrow;
  }
}
