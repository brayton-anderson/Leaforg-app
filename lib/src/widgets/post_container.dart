import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import '../elements/social/utils.dart';
import '../models/user.dart';
import '../soconfig/pallete.dart';
import '../widgets/widgets.dart';

class PostContainer extends StatelessWidget {
  final DocumentSnapshot<Object> post;
  final bool isFromThread;
  //final Function threadItemAction;
  final int commentCount;

  final Userss myData;
  final ValueChanged<Userss> updateMyDataToMain;

  PostContainer({
    Key key,
    // @required this.data,
    //@required tsshis.data,
    @required this.isFromThread,
    // @required this.threadItemAction,
    @required this.commentCount,
    @required this.updateMyDataToMain,
    @required this.myData,
    @required this.post,
    // @required this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //FirebaseServices firebaseServices = FirebaseServices();
    final bool isDesktop = Responsive.isDesktop(context);

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(
                    data: post,
                    commentCount: commentCount,
                    isFromThread: isFromThread,
                    myData: myData,
                    // threadItemAction: threadItemAction,
                    updateMyDataToMain: updateMyDataToMain,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    post['postContent'],
                    style: TextStyle(fontSize: 14.0).copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  post['postImage'] != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post['postImage'] == 'NONE'
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(imageUrl: post['postImage']),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(
                data: post,
                //currentData: _currentMyData,
                commentCount: commentCount,
                isFromThread: isFromThread,
                myData: myData,
                //threadItemAction: threadItemAction,
                updateMyDataToMain: updateMyDataToMain,
                // likescount: _likeCount
              ),
            ),
          ],
        ),
      ),
    );
    // });

    // }),
    //);
    // });
  }
}

class _PostHeader extends StatelessWidget {
  final DocumentSnapshot<Object> data;
  final Userss myData;
  final ValueChanged<Userss> updateMyDataToMain;
  final bool isFromThread;
  final Function threadItemAction;
  final int commentCount;

  const _PostHeader({
    Key key,
    @required this.data,
    @required this.updateMyDataToMain,
    @required this.myData,
    @required this.threadItemAction,
    @required this.isFromThread,
    @required this.commentCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var i = 0;
    // i++;
    return Row(
      children: [
        ProfileAvatar(),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['userName'],
                  style: const TextStyle(fontSize: 14.0).copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Text(
                    '${Utils.readTimestamp(data['postTimeStamp'])} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends StatefulWidget {
  final DocumentSnapshot<Object> data;
  final Userss myData;
  final ValueChanged<Userss> updateMyDataToMain;
  final bool isFromThread;
  final Function threadItemAction;
  final int commentCount;
  // int likescount;
  //Userss currentData;

  _PostStats({
    Key key,
    @required this.data,
    // @required this.currentData,
    @required this.updateMyDataToMain,
    @required this.myData,
    @required this.threadItemAction,
    @required this.isFromThread,
    @required this.commentCount,
    // @required this.likescount,
  }) : super(key: key);

  __PostStatsState createState() => __PostStatsState();
}

class __PostStatsState extends State<_PostStats> {
  var i = 0;

  Userss _currentMyData;
  int _likeCount;
  @override
  void initState() {
    _currentMyData = widget.myData;
    _likeCount = widget.data['postLikeCount'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    i++;
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${widget.isFromThread ? widget.data['postLikeCount'] : _likeCount}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${widget.commentCount} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${widget.commentCount} Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                PhosphorIcons.hands_clapping_fill,
                color: Theme.of(context).hintColor,
                size: 25.0,
              ),
              label: 'Like',
              onTap: () => _updateLikeCount(_currentMyData.myLikeList != null &&
                      _currentMyData.myLikeList.contains(widget.data['postID'])
                  ? true
                  : false),
            ),
            _PostButton(
              icon: Icon(
                PhosphorIcons.chat_teardrop_dots_fill,
                color: Colors.purpleAccent,
                size: 25.0,
              ),
              label: 'Comment',
              onTap: () => widget.isFromThread
                  ? widget.threadItemAction(widget.data)
                  : null,
            ),
            _PostButton(
              icon: Icon(
                PhosphorIcons.share_network_light,
                color: Theme.of(context).secondaryHeaderColor,
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }

  void _updateLikeCount(bool isLikePost) async {
    //data;
    Userss _newProfileData = await Utils.updateLikeCount(
        widget.data,
        widget.myData.myLikeList != null &&
                widget.myData.myLikeList.contains(widget.data['postID'])
            ? true
            : false,
        widget.myData,
        widget.updateMyDataToMain,
        true);
    setState(() {
      _currentMyData = _newProfileData;
    });
    setState(() {
      isLikePost ? _likeCount-- : _likeCount++;
    });
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
