import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/social_models/social_thread.dart';

//import 'package:firebase/firestore.dart';
class FirebaseServices {
  //FirebaseFirestore _fireStoreDataBase = Firestore..instance;

  Stream<List<ThreadModel>> getUserPosts() {
    return FirebaseFirestore.instance
        .collection('thread')
        .orderBy('postTimeStamp', descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ThreadModel.fromJson(document.data()))
            .toList());
  }
}
