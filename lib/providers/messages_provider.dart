import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/model/message_model.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';
import 'package:quick_chat/services/firestore_services.dart';

final messageProvider = StreamProvider.autoDispose
    .family<QuerySnapshot<Map<String, dynamic>>, ChatUserModel>(
        (ref, chatUser) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getAllMessages(chatUser);
});
final lastMessageProvider =
    StreamProvider.autoDispose.family<MessageModel?, String>((ref, chatUserID) {
  final FirestoreServices services = FirestoreServices();

  final reference = FirebaseFirestore.instance
      .collection('chats/${services.getConvoID(chatUserID)}/messages')
      .orderBy('sentTime', descending: true) // Get the latest message
      .limit(1);

  return reference.snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) return null;
    return MessageModel.fromJson(snapshot.docs.first.data());
  });
});



final chatTileProvider = StreamProvider.autoDispose
    .family<({MessageModel? lastMessage, int unreadCount}), String>(
        (ref, chatUserID) {
  final user = FirebaseAuth.instance.currentUser!;
  final FirestoreServices services = FirestoreServices();
  final reference = FirebaseFirestore.instance
      .collection('chats/${services.getConvoID(chatUserID)}/messages');
  return reference.snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) return (lastMessage: null, unreadCount: 0);
    final lastMsg = MessageModel.fromJson(snapshot.docs.last.data());

    // to count unread messages --
    int unreadCount = snapshot.docs
        .where((doc) =>
            doc['receiverID'] == user.uid &&
            (doc['readTime'] == null || doc['readTime'] == ''))
        .length;
    return (lastMessage: lastMsg, unreadCount: unreadCount);
  });
});
