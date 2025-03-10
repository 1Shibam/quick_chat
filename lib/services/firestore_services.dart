import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/Exports/common_exports.dart';

import 'package:quick_chat/model/user_model.dart';

class FirestoreServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // checking if the user exists or not -

  Future<bool> userExists() async {
    //check the database -
    return (await firestore
            .collection('chatUsers')
            .doc(_auth.currentUser!.uid)
            .get())
        .exists;
  }


}

final userProvider = StreamProvider<List<ChatUserModel>>((ref) {
  try {
    final snapshots =
        FirebaseFirestore.instance.collection('chatUsers').snapshots();
    final users = snapshots.map((snap) {
      return snap.docs.map((doc) {
        return ChatUserModel.fromJson(doc.data());
      }).toList();
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
