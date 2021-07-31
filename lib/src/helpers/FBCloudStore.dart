import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../repository/user_repository.dart';
import '../models/user.dart';
import '../elements/social/utils.dart';
import '../helpers/FBCloudMessaging.dart';

class FBCloudStore {
  static Future<void> sendPostInFirebase(String postID, String postContent,
      Userss userProfile, String postImageURL) async {
    FirebaseFirestore.instance.collection('thread').doc(postID).set({
      'postID': postID,
      'userName': currentUser.value.name,
      'userThumbnail': currentUser.value.image.thumb,
      'postTimeStamp': DateTime.now().millisecondsSinceEpoch,
      'postContent': postContent,
      'postImage': postImageURL,
      'postLikeCount': 0,
      'postCommentCount': 0,
      'FCMToken': currentUser.value.deviceToken
    });
  }

  static Future<void> sendReportUserToFB(context, String reason,
      String userName, String postId, String content, String reporter) async {
    try {
      FirebaseFirestore.instance.collection('report').doc().set({
        'reason': reason,
        'author': userName,
        'postId': postId,
        'content': content,
        'reporter': reporter
      });
    } catch (e) {
      print('Report post error');
    }
  }

  static Future<void> likeToPost(
      String postID, Userss userProfile, bool isLikePost) async {
    if (isLikePost) {
      DocumentReference likeReference = FirebaseFirestore.instance
          .collection('thread')
          .doc(postID)
          .collection('like')
          .doc(currentUser.value.name);
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        await myTransaction.delete(likeReference);
      });
    } else {
      await FirebaseFirestore.instance
          .collection('thread')
          .doc(postID)
          .collection('like')
          .doc(currentUser.value.name)
          .set({
        'userName': currentUser.value.name,
        'userThumbnail': currentUser.value.image.thumb,
      });
    }
  }

  static Future<void> updatePostLikeCount(
      DocumentSnapshot postData, bool isLikePost, Userss myProfileData) async {
    postData.reference
        .update({'postLikeCount': FieldValue.increment(isLikePost ? -1 : 1)});
    if (!isLikePost) {
      await FBCloudMessaging.instance.sendNotificationMessageToPeerUser(
          '${currentUser.value.name} likes your post',
          '${currentUser.value.name}',
          postData['FCMToken']);
    }
  }

  static Future<void> updatePostCommentCount(
    DocumentSnapshot postData,
  ) async {
    postData.reference.update({'postCommentCount': FieldValue.increment(1)});
  }

  static Future<void> updateCommentLikeCount(
      DocumentSnapshot postData, bool isLikePost, Userss myProfileData) async {
    postData.reference.update(
        {'commentLikeCount': FieldValue.increment(isLikePost ? -1 : 1)});
    if (!isLikePost) {
      await FBCloudMessaging.instance.sendNotificationMessageToPeerUser(
          '${currentUser.value.name} likes your comment',
          '${currentUser.value.name}',
          postData['FCMToken']);
    }
  }

  static Future<void> commentToPost(
      String toUserID,
      String toCommentID,
      String postID,
      String commentContent,
      Userss userProfile,
      String postFCMToken) async {
    String commentID =
        Utils.getRandomString(8) + Random().nextInt(500).toString();
    FirebaseFirestore.instance
        .collection('thread')
        .doc(postID)
        .collection('comment')
        .doc(commentID)
        .set({
      'toUserID': toUserID,
      'commentID': commentID,
      'toCommentID': toCommentID,
      'userName': currentUser.value.name,
      'userThumbnail': currentUser.value.image.thumb,
      'commentTimeStamp': DateTime.now().millisecondsSinceEpoch,
      'commentContent': commentContent,
      'commentLikeCount': 0,
      'FCMToken': currentUser.value.deviceToken
    });
    await FBCloudMessaging.instance.sendNotificationMessageToPeerUser(
        commentContent, '${currentUser.value.name} was commented', postFCMToken);
  }
}
