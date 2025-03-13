// Stream provider to fetch user
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/model/user_model.dart';

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
