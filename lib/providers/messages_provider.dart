import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final FirebaseAuth user = FirebaseAuth.instance;
  return FirebaseFirestore.instance
      .collection('chatMessages')
      .where('receiverID', isEqualTo: user.currentUser!.uid)
      .snapshots();
});


