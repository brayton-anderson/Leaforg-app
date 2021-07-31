import 'package:cloud_firestore/cloud_firestore.dart';

import '../../helpers/custom_trace.dart';

class ThreadModel {
  final String postID;
  final String userName;
  final String userThumbnail;
  final String postTimeStamp;
  final String postContent;
  final String postImage;
  final int postLikeCount;
  final int postCommentCount;
  final String FCMToken;
  final DocumentReference reference;

  ThreadModel({
    this.postID,
    this.userName,
    this.userThumbnail,
    this.postTimeStamp,
    this.postContent,
    this.postImage,
    this.postLikeCount,
    this.postCommentCount,
    this.FCMToken,
    this.reference,
  });

  ThreadModel.fromJson(Map<String, dynamic> parsedJSON, {this.reference})
      : assert(parsedJSON['postID'] != null),
        assert(parsedJSON['userName'] != null),
        assert(parsedJSON['userThumbnail'] != null),
        assert(parsedJSON['postTimeStamp'] != null),
        assert(parsedJSON['postContent'] != null),
        assert(parsedJSON['postImage'] != null),
        assert(parsedJSON['postLikeCount'] != null),
        assert(parsedJSON['postCommentCount'] != null),
        assert(parsedJSON['FCMToken'] != null),
        postID = parsedJSON['postID'].toString(),
        userName = parsedJSON['userName'],
        userThumbnail = parsedJSON['userThumbnail'],
        postTimeStamp = parsedJSON['postTimeStamp'],
        postContent = parsedJSON['postContent'],
        postImage = parsedJSON['postImage'],
        postLikeCount = parsedJSON['postLikeCount'],
        postCommentCount = parsedJSON['postCommentCount'],
        FCMToken = parsedJSON['FCMToken'];

  ThreadModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data(), reference: snapshot.reference);
}
