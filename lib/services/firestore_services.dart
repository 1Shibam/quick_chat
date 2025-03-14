import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/services/pick_image.dart';
import 'package:quick_chat/services/upload_image_to_imgur.dart';

class FirestoreServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user profile if it doesn't exist
  Future<void> createUserProfile() async {
    final user = _auth.currentUser!;
    final userDocRef = firestore.collection('chatUsers').doc(user.uid);

    // Check if user already exists (avoiding an extra function call)
    final userDoc = await userDocRef.get();
    if (userDoc.exists) return;

    final userInfo = ChatUserModel(
      userID: user.uid,
      username: user.displayName ?? 'Unnamed User', // Handle null
      email: user.email ?? '',
      bio: '',
      dob: '',
      fullName: user.displayName ?? 'Unnamed User',
      isOnline: false,
      lastActive: '',
      gender: 'not specified',
      pushToken: '',
      createdAt: Timestamp.now()
          .toDate()
          .toIso8601String()
          .split('.')[0], // Use Firestore Timestamp
      profileUrl: '',
    );

    await userDocRef.set(userInfo.toJson());
  }

  //update profile picture in firestore --

  Future<void> updateProfilePicture(
      String userId, ImageSource source, BuildContext context) async {
    File? image = await pickImage(source, context);
    if (image == null) return;
    if (!context.mounted) return;

    String? imageUrl = await uploadImageToImgur(context, image);
    if (imageUrl != null && context.mounted) {
      await updateUserData(
        userID: userId,
        context: context,
        updates: {'profile_url': imageUrl},
      );
    }
  }

  //update user name method

  Future<void> updateUserName(
      {required String userID,
      required String newUserName,
      required BuildContext context}) async {
    try {
      await updateUserData(
          userID: userID, updates: {'username': newUserName}, context: context);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'Error - $e');
      }
    }
  }

  //update full name method
  Future<void> updateFullName(
      {required String userID,
      required String newName,
      required BuildContext context}) async {
    try {
      await updateUserData(
          userID: userID, updates: {'full_name': newName}, context: context);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'Error - $e');
      }
    }
  }

  //update user bio
  Future<void> updateBio(
      {required String userID,
      required String newBio,
      required BuildContext context}) async {
    try {
      await updateUserData(
          userID: userID, updates: {'bio': newBio}, context: context);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'Error - $e');
      }
    }
  }

  //change user gender - lmao no.........
  Future<void> updateGender(
      {required String userID,
      required String newGeder,
      required BuildContext context}) async {
    try {
      await updateUserData(
          userID: userID, updates: {'gender': newGeder}, context: context);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'Error - $e');
      }
    }
  }

  //change dob ---
  Future<void> updateDOB(
      {required String userID,
      required String newDob,
      required BuildContext context}) async {
    try {
      await updateUserData(
          userID: userID, updates: {'dob': newDob}, context: context);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        buildSnackBar(context, 'Error - $e');
      }
    }
  }

  // Single method to update user Data - this method finalizes updates
  Future<void> updateUserData(
      {required String userID,
      required Map<String, dynamic> updates,
      required BuildContext context}) async {
    try {
      await firestore.collection('chatUsers').doc(userID).update(updates);
    } on FirebaseException catch (error) {
      if (context.mounted) {
        buildSnackBar(context, 'Error: $error');
        context.pop();
      }
    }
  }
}
