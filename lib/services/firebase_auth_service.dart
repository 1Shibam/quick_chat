import 'package:firebase_auth/firebase_auth.dart';

import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/services/firestore_services.dart';

import 'package:quick_chat/widgets/common_widgets/build_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        // Call createUserProfile() only if email is verified
        await FirestoreServices().createUserProfile();
        if (context.mounted) {
          buildSnackBar(context, 'Welcome!!');
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed';
      // print(e.code);

      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Please enter email and password correct';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;

        case 'user-disabled':
          errorMessage = 'The user account has been disabled';
          break;
        case 'user-not-verified':
          errorMessage = 'Please verify your email first';
      }
      if (context.mounted) {
        buildSnackBar(context, errorMessage, bgColor: AppColors.errorRed);
      }
    } catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'unexpected error occured!',
            bgColor: AppColors.errorRed);
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
      if (context.mounted) {
        buildSnackBar(context, e.message.toString(),
            bgColor: AppColors.errorRed);
      }
    }
  }

  //! Forgot password - Reset passwor --

  Future<void> forgotPasswordReset(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        buildSnackBar(
            context, 'If an account exists, a reset email has been sent!',
            bgColor: AppColors.darkGreen);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'Error - ${e.message}');
      }
    }
  }

  //! signup / signin with google with google -
  Future<void> sigupWithGoogle(BuildContext context) async {
    try {
      //? making sure the previous accounts are signed out if the users did sign out -
      await GoogleSignIn().signOut();
      //? Starting the singUp process!!
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      //? User cancelled the signup process
      if (googleUser == null) {
        if (context.mounted) {
          buildSnackBar(context, 'Process Cancelled',
              bgColor: AppColors.errorRedAccent);
        }
        return;
      }
      //? getting google auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // If user exists, directly sign them in
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await FirestoreServices().createUserProfile();
        if (context.mounted) {
          buildSnackBar(
              context, 'Welcome , ${userCredential.user!.displayName}!');
          context.go(RouterNames.home);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'something went wrong : ${e.message}');
      }
    }
  }
}
