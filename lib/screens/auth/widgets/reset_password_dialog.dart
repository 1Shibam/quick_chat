import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';
import 'package:quick_chat/services/firebase_auth_service.dart';
import 'package:quick_chat/widgets/common_widgets/cirular_loader.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({super.key});

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final TextEditingController emailController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void submitForm(email) async {
    if (fromKey.currentState?.validate() ?? false) {
      // Show loading dialog
      ciruclarLoader(context);

      await sendLink(email);

      // Close the loading dialog
      if (context.mounted) {
        // Close loading dialog
        Navigator.pop(context); // Close ResetPasswordDialog
        Navigator.pop(context); // Close ResetPasswordDialog
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fromKey,
      child: AlertDialog(
        backgroundColor: AppColors.darkGreen,
        title: Text(
          'Reset-Password',
          style: AppTextStyles.heading1,
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildTextField(
                  preWidget: const Icon(Icons.mail),
                  label: 'Email',
                  controller: emailController,
                  validator: validateEmail),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'A link will be sent to your registered email address you can reset your password from there',
                style: AppTextStyles.buttonText,
                softWrap: true,
              ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: () {
                  submitForm(emailController.text);
                },
                child: const BuildPrimaryButton(text: 'Send Link'),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendLink(String email) async {
    final FirebaseAuthServices auth = FirebaseAuthServices();
    await auth.forgotPasswordReset(context, email);
  }
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email can\'t be empty';
  }
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}
