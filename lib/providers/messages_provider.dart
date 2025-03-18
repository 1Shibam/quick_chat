import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_chat/model/user_model.dart';
import 'package:quick_chat/providers/firestore_service_provider.dart';

final messageProvider =
    StreamProvider.family<QuerySnapshot<Map<String, dynamic>>, ChatUserModel>(
        (ref, chatUser) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getAllMessages(chatUser);
});
