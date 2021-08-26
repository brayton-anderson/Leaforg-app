import 'package:cloud_firestore/cloud_firestore.dart';
import 'stories.dart';

import '../helpers/custom_trace.dart';

class StoriesuserModel {
  String storyuserid;
  String device_token;
  String first_story_image;
  int first_story_timestamp;
  int storyuser_timestamp;
  String user_id;
  String user_image;
  String user_name;

  StoriesuserModel({
    this.storyuserid,
    this.device_token,
    this.first_story_image,
    this.first_story_timestamp,
    this.storyuser_timestamp,
    this.user_id,
    this.user_image,
    this.user_name,
  });

  StoriesuserModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      storyuserid = jsonMap['id'].toString();
      user_name = jsonMap['user_name'].toString();
      user_image = jsonMap['user_image'];
      storyuser_timestamp = jsonMap['storyuser_timestamp'];
      device_token = jsonMap['device_token'];
      first_story_image = jsonMap['first_story_image'];
      first_story_timestamp = jsonMap['first_story_timestamp'];
    } catch (e) {
      storyuserid = '';
      user_name = '';
      user_image = '';
      storyuser_timestamp = 0;
      device_token = '';
      first_story_image = '';
      first_story_timestamp = 0;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toMap(StoriesModel founded) {
    return {
      'id': storyuserid,
      'user_name': user_name,
      'user_image': user_image,
      'storyuser_timestamp': storyuser_timestamp,
      'device_token': device_token,
    };
  }

  StoriesuserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    storyuserid = documentSnapshot.id;
    device_token = documentSnapshot['device_token'];
    first_story_image = documentSnapshot['first_story_image'];
    first_story_timestamp = documentSnapshot['first_story_timestamp'];
    storyuser_timestamp = documentSnapshot['storyuser_timestamp'];
    user_id = documentSnapshot['user_id'];
    user_image = documentSnapshot['user_image'];
    user_name = documentSnapshot['user_name'];
  }

  StoriesuserModel.fromquerySnapshot(
    QueryDocumentSnapshot documentSnapshot,
  ) {
    storyuserid = documentSnapshot.id;
    device_token = documentSnapshot['device_token'];
    first_story_image = documentSnapshot['first_story_image'];
    first_story_timestamp = documentSnapshot['first_story_timestamp'];
    storyuser_timestamp = documentSnapshot['storyuser_timestamp'];
    user_id = documentSnapshot['user_id'];
    user_image = documentSnapshot['user_image'];
    user_name = documentSnapshot['user_name'];
  }
}
