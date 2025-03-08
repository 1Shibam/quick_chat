// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';


import 'package:quick_chat/screens/auth/widgets/bottom_rich_texts_widget.dart';
import 'package:quick_chat/screens/auth/widgets/reset_password_dialog.dart';
import 'package:quick_chat/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //! Text Editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  //! Focus nodes
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();

  //! bool for password visibility toggle
  bool isVisible = true;
  bool hasRecentLogins = false;

  //! Form Key for validation
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    emailFocus.dispose();
    passFocus.dispose();

    super.dispose();
  }

  /// Handle form submission
  void submitForm() async {
    if (formkey.currentState!.validate()) {
      //! showing loading dialog before login starts

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const LoadingAnimation(
            opacity: 0.4,
            height: 100,
            width: 100,
          );
        },
      );

      await attemptLogin();
    } else {
      buildSnackBar(context, 'Please Fill all the fields correctly',
          bgColor: AppColors.errorRed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: Form(
            key: formkey, // Attach form key
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login to continue",
                    style: AppTextStyles.heading1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  BuildTextField(
                    controller: emailController,
                    focusNode: emailFocus,
                    preWidget: const Icon(Icons.email),
                    label: 'Email',
                    submitField: (_) {
                      if (emailController.text.trim().isNotEmpty) {
                        FocusScope.of(context).requestFocus(passFocus);
                      }
                    },
                    validator: validateEmail, // Pass function reference
                  ),
                  SizedBox(height: 16.h),
                  BuildTextField(
                    controller: passController,
                    focusNode: passFocus,
                    label: 'Password',
                    isPassword: isVisible,
                    preWidget: const Icon(Icons.lock),
                    suffWidget: IconButton(
                      onPressed: () => setState(() {
                        isVisible = !isVisible;
                      }),
                      icon: Icon(
                          isVisible ? Icons.visibility_off : Icons.visibility),
                      color:
                          isVisible ? AppColors.darkGreen : AppColors.softWhite,
                    ),
                    validator: validatePassword, // Pass function reference
                    submitField: (_) => submitForm(),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: submitForm,
                    child: const BuildPrimaryButton(
                      text: 'Login',
                      // Ensure button calls submitForm()
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ResetPasswordDialog();
                        },
                      );
                    },
                    child: const BuildPrimaryButton(
                      color: Colors.transparent,
                      text: 'Forgot Password?',
                      // Ensure button calls submitForm()
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const BottomRichTextWidget(
                      text1: 'Don\'t have an account?',
                      text2: ' Sign Up',
                      pageName: RouterNames.signup),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingAnimation(
                            opacity: 0.4,
                            height: 40,
                            width: 40,
                          );
                        },
                      );
                      await FirebaseAuthServices().sigupWithGoogle(context);
                      context.pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.darkGreen,
                          borderRadius: BorderRadius.circular(20.r)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/images/google-color-svgrepo-com.svg',
                            height: 28.h,
                            width: 28.w,
                          ),
                          Text(
                            'Continue With Google',
                            style: AppTextStyles.heading3,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Attempting to log in -

  attemptLogin() async {
    try {
      //Attempting to log in with email and password -
      await FirebaseAuthServices().loginWithEmail(
          context, emailController.text.trim(), passController.text.trim());
      //check if email is verified -
      final user = FirebaseAuth.instance.currentUser;
      Navigator.pop(context);
      if (user == null) {
        return;
      }
      if (user.emailVerified) {
        context.go(RouterNames.home);
      } else {
        Navigator.pop(context);
        buildSnackBar(context, 'Please verify you email first',
            bgColor: AppColors.darkGreen);
      }
    } catch (e) {
      Navigator.pop(context);
      buildSnackBar(context, e.toString(), bgColor: AppColors.darkGreen);
    }
  }
}

// Email validation function
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

/// Password validation function
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password can\'t be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
