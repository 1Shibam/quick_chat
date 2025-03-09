import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collection('chatUsers').snapshots();
});
