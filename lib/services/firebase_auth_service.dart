// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:quick_chat/theme/app_colors.dart';
import 'package:quick_chat/widgets/common_widgets/build_snackbar.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth; //firebase instance
  FirebaseAuthServices(this._auth);

  //! Signup with email
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    //? using context here to pass some widgets like snackbar and alret dialog for proper auth messages

    try {
      final userCreds = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (context.mounted) {
        if (!userCreds.user!.emailVerified) {
          await sendEmailVerification(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'An error occured during Signup!!';
      switch (e.code) {
        case 'weak-password':
          errorMsg = 'The password provided is too weak';
          break;
        case 'email-already-in-use':
          errorMsg = 'This email is already in use';
          break;
        case 'invalid-email':
          errorMsg = 'The entered email is invalid';
          break;
      }
      if (context.mounted) {
        buildSnackBar(context, errorMsg, bgColor: AppColors.grey);
      }
    } catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'An un expected error occured!!',
            bgColor: AppColors.grey);
      }
    }
  }

  //! Login with Email - For the user who already have and account...

  Future<void> loginWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed';
      print(e.code);

      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'There is no user with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;

        case 'user-disabled':
          errorMessage = 'The user account has been disabled';
          break;
      }
      if (context.mounted) {
        buildSnackBar(context, errorMessage, bgColor: AppColors.grey);
      }
    } catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'unexpected error occured!',
            bgColor: AppColors.grey);
      }
    }
  }

  //! Email verification can't let fake emails sign up can we?

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      if (context.mounted) {
        buildSnackBar(context, 'Email verification sent!',
            bgColor: AppColors.darkGreen);
      }
    } on FirebaseException catch (e) {
      buildSnackBar(context, e.message.toString(), bgColor: AppColors.grey);
    }
  }

  //! Phone sign-in(only for android and IOS )
  Future<void> singInWithPhoneNum(BuildContext context, String number) async {
    await _auth.verifyPhoneNumber(
      //? verification complted only works only on android we are checking it that if we received any otp then we will signup with the otp
      verificationCompleted: (PhoneAuthCredential creadential) async {
        await _auth.signInWithCredential(creadential);
      },
      verificationFailed: (error) {
        buildSnackBar(context, error.message.toString());
      },
      codeSent: (String verificationId, int? forceResendingToken) async {},
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
