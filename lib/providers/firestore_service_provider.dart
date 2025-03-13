import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/widgets_export.dart';
import 'package:quick_chat/services/firestore_services.dart';

final firestoreServiceProvider =
    Provider<FirestoreServices>((ref) => FirestoreServices());

class FirestoreServiceNotifier extends StateNotifier<FirestoreServices> {
  FirestoreServiceNotifier(super.services);

  Future<bool> createProfile(BuildContext context) async {
    try {
      await state.createUserProfile();
      if (context.mounted) {
        buildSnackBar(context, 'User creation successfull');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeUserName(
      BuildContext context, String userID, String newUserName) async {
    try {
      await state.updateUserName(
          userID: userID, context: context, newUserName: newUserName);
      if (context.mounted) {
        buildSnackBar(context, 'update successfull');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeFullName(
      BuildContext context, String userID, String newName) async {
    try {
      await state.updateFullName(
          userID: userID, context: context, newName: newName);
      if (context.mounted) {
        buildSnackBar(context, 'update successfull');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeBio(
      BuildContext context, String userID, String newBio) async {
    try {
      await state.updateBio(userID: userID, context: context, newBio: newBio);
      if (context.mounted) {
        buildSnackBar(context, 'update  successfull');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeDob(
      BuildContext context, String userID, String newDob) async {
    try {
      await state.updateDOB(userID: userID, context: context, newDob: newDob);
      if (context.mounted) {
        buildSnackBar(context, 'update successfull');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeGender(
      BuildContext context, String userID, String newGender) async {
    try {
      await state.updateGender(
          userID: userID, context: context, newGeder: newGender);
      if (context.mounted) {
        buildSnackBar(context, 'update successfull');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeUserData(
      {required BuildContext context,
      required Map<String, dynamic> changes,
      required String userID}) async {
    try {
      await state.updateUserData(
          userID: userID, updates: changes, context: context);
      return true;
    } catch (e) {
      return false;
    }
  }
}
