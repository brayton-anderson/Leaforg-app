import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_repository.dart';
import '../models/userstories.dart';

import '../models/stories.dart';

class StoriesRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> sendStoryInFirebase(String storyid, String story_content,
      String story_image, String story_isviewed) async {
    FirebaseFirestore.instance.collection('story').doc(storyid).set({
      'storyid': storyid,
      'story_timestamp': DateTime.now().millisecondsSinceEpoch,
      'story_content': story_content,
      'story_image': story_image,
      'story_isviewed': story_isviewed,
      'story_likecount': 0,
      'story_commentcount': 0,
    });
  }

  static Future<void> sendUserStoryInFirebase(String storyid,
      String storyuserid, String story_image, String story_isviewed) async {
    FirebaseFirestore.instance.collection('stories').doc(storyid).set({
      'storyuserid': storyuserid,
      'storyid': storyid,
      'storyuser_timestamp': DateTime.now().millisecondsSinceEpoch,
      'user_name': currentUser.value.name,
      'user_image': currentUser.value.image.thumb,
      'device_token': currentUser.value.deviceToken,
    });
  }

  Future<void> addStories(bool newvalue, String uid, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("userstories")
          .doc(currentUser.value.id)
          .collection("stories")
          .add({
        'story_commentcount': 0,
        'story_content': 'hello there',
        'story_image':
            'https://firebasestorage.googleapis.com/v0/b/leaforg-8c873.appspot.com/o/images%2F4l8xS2lR157%2FpostImage?alt=media&token=48e5a6fc-e4e2-4dce-99ea-88428174d0e6',
        'story_isviewed': false,
        'story_likecount': 0,
        'story_timestamp': DateTime.now().millisecondsSinceEpoch,
        'storyuserid': currentUser.value.id,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Stream<List<StoriesuserModel>> userstoriesStream() {
  //   return _firestore
  //       .collection("userstories")
  //       .orderBy("storyuser_timestamp", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<StoriesuserModel> retVal = [];
  //     query.docs.forEach((element) {
  //       retVal.add(StoriesuserModel.fromDocumentSnapshot(element));
  //     });
  //     return retVal;
  //   });
  // }
  Stream<List<StoriesModel>> todoStream(String uid) {
    return FirebaseFirestore.instance
        .collection("userstories")
        .doc(uid)
        .collection("stories")
        .orderBy("story_timestamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<StoriesModel> retVal = [];
      query.docs.forEach((element) {
        print('hotutututmessage');
        print(element.id);
        retVal.add(StoriesModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<StoriesuserModel>> getUserStories() {
    try {
      return FirebaseFirestore.instance
          .collection("userstories")
          .orderBy("storyuser_timestamp", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
            List<StoriesuserModel> retVal = [];
            query.docs.forEach((element) {
        print('hotutututmessage');
        print(element.reference);
        retVal.add(StoriesuserModel.fromquerySnapshot(element));
      });
      return retVal;
          });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<StoriesuserModel> getUser() async {
    try {
      var userstoriesdata = await FirebaseFirestore.instance
          .collection("userstories")
          .doc(currentUser.value.id)
          .get();

      return StoriesuserModel.fromDocumentSnapshot(userstoriesdata);
    } catch (e) {
      print(e);
      await FirebaseFirestore.instance
          .collection('userstories')
          .doc(currentUser.value.id)
          .set({
        "device_token": currentUser.value.deviceToken,
        "first_story_image": 'NONE',
        "first_story_timestamp": 'NONE',
        "storyuser_timestamp": DateTime.now().millisecondsSinceEpoch,
        "user_id": currentUser.value.id,
        "user_image": currentUser.value.image.thumb,
        "user_name": currentUser.value.name,
      });
      rethrow;
    }
  }
}
