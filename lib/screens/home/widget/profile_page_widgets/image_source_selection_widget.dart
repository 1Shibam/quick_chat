import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_chat/model/user_model.dart';

import 'package:quick_chat/screens/home/widget/profile_page_widgets/image_source_selection.dart';

import '../../../../Exports/common_exports.dart';

class ImageSelectionOptionWidget extends ConsumerWidget {
  const ImageSelectionOptionWidget({
    super.key,
    required this.userData,
  });

  final ChatUserModel userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        _showBottomShett(context: context, userData: userData);
      },
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
            color: AppColors.softGrey,
            borderRadius: BorderRadius.circular(40.r)),
        child: const Icon(
          Icons.edit,
          color: AppColors.darkGreenAccent,
        ),
      ),
    );
  }
}

//show bottom sheet on tap of the pencil icon

void _showBottomShett(
    {required BuildContext context, required ChatUserModel userData}) {
  showModalBottomSheet(
    backgroundColor: AppColors.darkGreen,
    elevation: 20,
    isDismissible: true,
    enableDrag: true,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return ImageSourceOptions(
        userData: userData,
      );
    },
  );
}
