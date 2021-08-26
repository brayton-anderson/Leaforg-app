import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/custom_trace.dart';

class StoriesModel {
  String storyid;
  int story_commentcount;
  String story_content;
  String story_image;
  bool story_isviewed;
  int story_likecount;
  int story_timestamp;
  String storyuserid;

  StoriesModel(
    this.storyid,
    this.story_commentcount,
    this.story_content,
    this.story_image,
    this.story_isviewed,
    this.story_likecount,
    this.story_timestamp,
    this.storyuserid,
  );

  StoriesModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      storyid = jsonMap['id'].toString();
      storyuserid = jsonMap['storyuserid'].toString();
      story_likecount = jsonMap['story_likecount'] ?? 0;
      story_commentcount = jsonMap['story_commentcount'] ?? 0;
      story_content = jsonMap['story_content'];
      story_image = jsonMap['story_image'];
      story_timestamp = jsonMap['story_timestamp'];
      story_isviewed = jsonMap['story_isviewed'] ?? false;
    } catch (e) {
      storyuserid = '';
      storyid = '';
      story_likecount = 0;
      story_commentcount = 0;
      story_content = '';
      story_image = '';
      story_timestamp = 0;
      story_isviewed = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'storyid': storyid,
      'storyuserid': storyuserid,
      'story_likecount ': story_likecount,
      'story_commentcount': story_commentcount,
      'story_content': story_content,
      'story_image': story_image,
      'story_timestamp': story_timestamp,
      'story_isviewed': story_isviewed,
    };
  }

  StoriesModel.fromDocumentSnapshot(
    QueryDocumentSnapshot documentSnapshot,
  ) {
    storyid = documentSnapshot.id;
    story_commentcount = documentSnapshot['story_commentcount'];
    story_content = documentSnapshot['story_content'];
    story_image = documentSnapshot['story_image'];
    story_isviewed = documentSnapshot['story_isviewed'];
    story_likecount = documentSnapshot['story_likecount'];
    story_timestamp = documentSnapshot['story_timestamp'];
    storyuserid = documentSnapshot['storyuserid'];

    print('lalalalala');
    print(documentSnapshot['story_content']);
  }
}
