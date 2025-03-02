// ignore_for_file: use_build_context_synchronously

import 'package:dashed_rect/dashed_rect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/screens/auth/widgets/bottom_rich_texts_widget.dart';
import 'package:quick_chat/services/firebase_auth_service.dart';

import 'package:quick_chat/widgets/common_widgets/build_snackbar.dart';
import 'package:quick_chat/widgets/common_widgets/build_primary_button.dart';
import 'package:quick_chat/widgets/common_widgets/build_text_field.dart';
import 'package:quick_chat/widgets/common_widgets/lottie_loading_animation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //! Text Editing controllers

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool checkBoxController = false;
  //! Focus nodes
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  //! bool for password visibitly toggle
  bool isVisible = true;
  bool isAlerted = false;

  //! Form key
  final formKey = GlobalKey<FormState>();

  /// Handle form submission
  void submitForm() async {
    if (formKey.currentState!.validate()) {
      // Show loading animation while signing up
      showDialog(
        context: context,
        builder: (context) {
          return const LottieLoadingAnimation(
            opacity: 0.4,
            height: 100,
            width: 100,
          );
        },
      );

      try {
        // Attempt to sign up with email and password
        await FirebaseAuthServices(FirebaseAuth.instance).signUpWithEmail(
          email: emailController.text,
          password: passController.text,
          context: context,
        );

        // Close the loading dialog after signup
        Navigator.pop(context);

        // Navigate to the login page
        context.go('/login');
      } catch (e) {
        Navigator.pop(context);
        buildSnackBar(context, e.toString(), bgColor: AppColors.grey);
      }
    } else if (checkBoxController == false) {
      setState(() {
        isAlerted = true;
      });
    } else {
      buildSnackBar(context, 'Please fill out all fields correctly',
          bgColor: AppColors.errorRed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up", style: AppTextStyles.heading1),
            SizedBox(height: 20.h),
            Form(
              key: formKey,
              child: Column(
                children: [
                  BuildTextField(
                    controller: nameController,
                    focusNode: nameFocus,
                    label: 'Full Name',
                    preWidget: const Icon(Icons.person),
                    submitField: (_) {
                      if (nameController.text.trim().isNotEmpty) {
                        FocusScope.of(context).requestFocus(emailFocus);
                      }
                    },
                    validator: validateName,
                  ),
                  SizedBox(height: 10.h),
                  BuildTextField(
                    controller: emailController,
                    focusNode: emailFocus,
                    label: 'Email',
                    preWidget: const Icon(Icons.email),
                    submitField: (_) {
                      if (nameController.text.trim().isNotEmpty) {
                        FocusScope.of(context).requestFocus(passFocus);
                      }
                    },
                    validator: validateEmail,
                  ),
                  SizedBox(height: 10.h),
                  BuildTextField(
                    controller: passController,
                    focusNode: passFocus,
                    preWidget: const Icon(Icons.lock),
                    label: 'Password',
                    isPassword: isVisible,
                    validator: validatePassword,
                    submitField: (_) => FocusScope.of(context).unfocus(),
                    suffWidget: IconButton(
                        onPressed: () => setState(() {
                              isVisible = !isVisible;
                            }),
                        icon: Icon(
                          //? for true value of isVisible the icon is in-active and for false its active
                          isVisible ? Icons.visibility_off : Icons.visibility,
                          color: isVisible
                              ? AppColors.darkGreen
                              : AppColors.softWhite,
                        )),
                  ),
                  SizedBox(height: 16.h),
                  isAlerted
                      ? DashedRect(
                          color: Colors.red,
                          strokeWidth: 2.h,
                          gap: 5, // Space between dashes

                          child: Row(
                            children: [
                              Checkbox(
                                side: const BorderSide(
                                    color: AppColors.grey, width: 3),
                                checkColor: AppColors.darkGreen,
                                activeColor: AppColors.softGrey,
                                value: checkBoxController,
                                onChanged: (value) {
                                  setState(() {
                                    checkBoxController = !checkBoxController;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'by continuing you accept out privacy policy and terms of use',
                                  style: AppTextStyles.bodyText
                                      .copyWith(color: AppColors.softGrey),
                                ),
                              )
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                  color: AppColors.darkGreenAccent, width: 3),
                              checkColor: AppColors.darkGreen,
                              activeColor: AppColors.softWhite,
                              value: checkBoxController,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxController = !checkBoxController;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'by continuing you accept out privacy policy and terms of use',
                                style: AppTextStyles.bodyText,
                              ),
                            )
                          ],
                        ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
                onTap: submitForm,
                child: const BuildPrimaryButton(text: 'Sign Up')),
            SizedBox(height: 10.h),
            const BottomRichTextWidget(
              text1: "Already have an account? ",
              text2: "Log in",
              pageName: RouterNames.login,
            ),
          ],
        ),
      ),
    );
  }
}

//! validation methods below
/// name validation function
String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'name cant be empty';
  }
  return null;
}

/// Email validation function
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
