// Stream provider to fetch user
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';

//? all user provider except current user
final otherUserProvider =
    StreamProvider.autoDispose<List<ChatUserModel>>((ref) {
  try {
    final FirebaseAuth user = FirebaseAuth.instance;

    final snapshots = FirebaseFirestore.instance
        .collection('chatUsers')
        .where('user_id', isNotEqualTo: user.currentUser!.uid)
        .snapshots();

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

//? current user provider
final currentUserProvider = StreamProvider.autoDispose<ChatUserModel>((ref) {
  try {
    final FirebaseAuth user = FirebaseAuth.instance;
    final String currentUseId = user.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('chatUsers')
        .doc(currentUseId)
        .snapshots()
        .map((doc) => ChatUserModel.fromJson(doc.data()!));
  } on FirebaseException catch (e, stackTrace) {
    debugPrint(e.message);
    debugPrintStack(stackTrace: stackTrace);
    rethrow;
  } catch (e, stackTrace) {
    debugPrint("Unexpected Error: $e");
    debugPrintStack(stackTrace: stackTrace);
    rethrow;
  }
});
