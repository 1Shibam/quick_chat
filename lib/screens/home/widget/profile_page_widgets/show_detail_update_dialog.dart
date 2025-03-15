import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';
import 'package:quick_chat/widgets/common_widgets/build_snackbar.dart';

enum UpdateFields { bio, username, fullName }

class ShowDetailUpdateDialog extends StatefulWidget {
  const ShowDetailUpdateDialog(
      {super.key,
      required this.initialVal,
      required this.title,
      required this.userId,
      required this.updateField,
      this.isBio = false});
  final String userId;
  final String initialVal;
  final String title;
  final UpdateFields updateField;
  final bool isBio;

  @override
  State<ShowDetailUpdateDialog> createState() => _ShowDetailUpdateDialogState();
}

class _ShowDetailUpdateDialogState extends State<ShowDetailUpdateDialog> {
  late TextEditingController updateController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    updateController = TextEditingController(text: widget.initialVal);
  }

  @override
  void dispose() {
    updateController.dispose();

    super.dispose();
  }

  Future<void> onSubmit({required WidgetRef ref}) async {
    final String newVal = updateController.text.trim();
    if (formKey.currentState!.validate()) {
      if (newVal == widget.initialVal) {
        //if no changes are made
        context.pop();
        return;
      }
      switch (widget.updateField) {
        case UpdateFields.bio:
          await ref
              .read(firestoreServiceStateNotifierProvider.notifier)
              .changeBio(context, widget.userId, newVal);
          break;
        case UpdateFields.username:
          await ref
              .read(firestoreServiceStateNotifierProvider.notifier)
              .changeUserName(context, widget.userId, newVal);
          break;

        case UpdateFields.fullName:
          await ref
              .read(firestoreServiceStateNotifierProvider.notifier)
              .changeFullName(context, widget.userId, newVal);
          break;

        default:
          buildSnackBar(context, 'bro tf you on');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        child: AlertDialog(
          backgroundColor: AppColors.darkGreen,
          title: Text('Update ${widget.title}', style: AppTextStyles.heading2),
          content: TextFormField(
            style: AppTextStyles.bodyText,
            maxLength: widget.isBio ? 50 : 16,
            maxLines: widget.isBio ? 3 : 1,
            validator: (value) {
              if (value == null || value.trim() == '') {
                return '${widget.title} can\'t be empty';
              } else {
                return null;
              }
            },
            controller: updateController,
            decoration: InputDecoration(
              hintText: 'Enter new ${widget.title.toLowerCase()}',
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: Text(
                'Cancel',
                style: AppTextStyles.buttonText,
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return TextButton(
                  onPressed: () async {
                    onSubmit(ref: ref);
                  },
                  child: Text(
                    'Update',
                    style: AppTextStyles.buttonText,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
