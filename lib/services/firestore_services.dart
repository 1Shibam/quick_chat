import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';
import 'package:quick_chat/model/user_model.dart';
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

  Future<void> updateUploadProfileUrl(
      String userId, ImageSource source, BuildContext context) async {
    final docRef = firestore.collection('chatUsers').doc(userId);
    final snapshot = await docRef.get();
    if (!snapshot.exists) return;
    if (!context.mounted) return;
    File? image = await pickImage(source, context);
    if (image == null) return;
    if (!context.mounted) return;
    String? imageUrl = await uploadImageToImgur(context, image);
    if (imageUrl != null) {
      await docRef.update({
        'profile_url': imageUrl, // Make sure this matches Firestore field name
      });
    }
  }

  // update user name -
}

// Stream provider for fetching all users
final userProvider = StreamProvider<List<ChatUserModel>>((ref) {
  try {
    final snapshots =
        FirebaseFirestore.instance.collection('chatUsers').snapshots();

    final users = snapshots.map((snap) {
      return snap.docs
          .map((doc) => ChatUserModel.fromJson(doc.data()))
          .toList();
    });

    return users;
  } on FirebaseException catch (error, stackTrace) {
    debugPrint(error.message);
    debugPrintStack(stackTrace: stackTrace);
    rethrow;
  } catch (e, stackTrace) {
    debugPrint("Unexpected Error: $e");
    debugPrintStack(stackTrace: stackTrace);
    rethrow;
  }
});

//pick image from gallery

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
