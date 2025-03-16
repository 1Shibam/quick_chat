import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final messageProvider = StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return FirebaseFirestore.instance.collection('chatMessages').snapshots();
});


/*
//? all user provider except current user
final otherUserProvider = StreamProvider<List<ChatUserModel>>((ref) {
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
 */