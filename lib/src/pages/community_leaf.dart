import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import '../models/social_models/social_thread.dart';
import '../repository/community_repositories/posts_thread_repository.dart';
import '../models/user.dart';
import '../widgets/widgets.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollController: _trackingScrollController),
          desktop:
              _HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  _HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Container(
                          alignment: Alignment.centerLeft,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/leaforg_icon_green.png"),
                              fit: BoxFit.contain,
                              alignment: Alignment.topLeft,
                            ),
                            color: Colors.transparent,
                          ),
                        ),
          centerTitle: false,
          floating: true,
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('Search'),
            ),
            CircleButton(
              icon: PhosphorIcons.chat_teardrop_text_light,
              iconSize: 30.0,
              onPressed: () => print('Messenger'),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            //child: Rooms(onlineUsers: onlineUsers),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
           // child: Stories(
            //  currentUser: currentUserss,
           //   stories: stories,
           // ),
          ),
        ),
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DocumentSnapshot data;
  final ValueChanged<Userss> updateMyData;
  final Userss myData;
  _HomeScreenDesktop({
    Key key,
    @required this.scrollController,
    @required this.updateMyData,
    @required this.myData,
    @required this.data,
  }) : super(key: key);
  final bool _isLoading = false;
  final Stream<QuerySnapshot> _threadsStream = FirebaseFirestore.instance
      .collection('thread')
      .orderBy('postTimeStamp', descending: true)
      .snapshots();

  final FirebaseServices firebaseServices = FirebaseServices();
  //List<ThreadModel> threadList;
  @override
  Widget build(BuildContext context) {
    List<ThreadModel> threadList;
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            //child: Padding(
            //  padding: const EdgeInsets.all(12.0),
           //   child: MoreOptionsList(
            //    currentUser: currentUserss,
             //   user: null,
            //  ),
            //),
          ),
        ),
        const Spacer(),
        Container(
          width: 600.0,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              // SliverPadding(
              //   padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
              //   sliver: SliverToBoxAdapter(
              //     child: Stories(
              //       currentUser: currentUserss,
              //       stories: stories,
              //     ),
              //   ),
              // ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(
                  child: CreatePostContainer(),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     height: 400,
              //     child: WritePost(),
              //   ),
              // ),

              // StreamBuilder(
              //     stream: _usersStream,
              //     builder: (context, snapshot) {
              //       //if (!snapshot.hasData) return LinearProgressIndicator();
              //       return
              // SliverToBoxAdapter(
              //   child: PostContainer(
              //     data: data,
              //     myData: myData,
              //     //userData: currentUser.value,
              //     updateMyDataToMain: updateMyData,
              //     threadItemAction: _moveToContentDetail,
              //     isFromThread: true,
              //     commentCount: data['postCommentCount'],
              //     parentContext: context,
              //   ),
              // ),

              //  SliverToBoxAdapter(
              //  child: PostContainer(
              // data: data,
              // myData: myData,
              //userData: currentUser.value,
              // updateMyDataToMain: updateMyData,
              // threadItemAction: _moveToContentDetail,
              // isFromThread: true,
              // commentCount: data['postCommentCount'],
              // parentContext: context,
              // ),
              // ),
              // }),
              // StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('thread')
              //         .orderBy('postTimeStamp', descending: true)
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       //if (!snapshot.hasData) return LinearProgressIndicator();
              //       return Wrap(
              //         children: <Widget>[
              //
              //
              //         snapshot.data.docs.length > 0
              // StreamProvider(
              //   create: (BuildContext context) =>
              //       firebaseServices.getUserPosts(),
              //   initialData: ThreadModel,
              //   child: SliverList(
              //     delegate: SliverChildBuilderDelegate(
              //       (context, index) {
              //         final ThreadModel post = threadList[index];
              //         return PostContainer(
              //           post: post,
              //           myData: myData,
              //           updateMyDataToMain: updateMyData,
              //         );
              //       },
              //       childCount: posts.length,
              //     ),
              //   ),
              // ),
              // StreamBuilder(
              //     stream: _threadsStream,
              //     builder: (context, snapshot) {
              //       return snapshot.hasData
              //           ? SliverList(
              //               delegate:
              //                   SliverChildListDelegate(List.generate(snapshot.data.length, (index) =>
              //                PostContainer(
              //                // data: snapshot.data,
              //                 myData: myData,
              //                 updateMyDataToMain: updateMyData,
              //               )).toList()))
              //           : Center(
              //               child: CircularProgressIndicator(),
              //             );
              //     }),
              SliverToBoxAdapter(
                child: Container(
                  height: 600,
                  child: StreamBuilder<QuerySnapshot>(
                      // <2> Pass `Stream<QuerySnapshot>` to stream
                      stream: FirebaseFirestore.instance
                          .collection('thread')
                          .orderBy('postTimeStamp', descending: true)
                          .snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                          final List<DocumentSnapshot> documents =
                              snapshot.data.docs;
                          return ListView(
                              children: documents
                                  .map((doc) => PostContainer(
                                        post: doc,
                                        isFromThread: true,
                                        commentCount: doc['postCommentCount'],
                                        myData: myData,
                                        updateMyDataToMain: updateMyData,
                                      ))
                                  .toList());
                        } else {
                          return Container(height: 0, width: 0);
                        }
                      }),
                ),
              ),

              //ListView(
              //                         shrinkWrap: true,
              //                         children: snapshot.data.docs.map((
              //                           DocumentSnapshot data,
              //                         ) {
              //                           PostContainer(
              //                             data: data,
              //                             myData: myData,
              //                             //userData: currentUser.value,
              //                             updateMyDataToMain: updateMyData,
              //                             threadItemAction:
              //                                 _moveToContentDetail,
              //                             isFromThread: true,
              //                             commentCount:
              //                                 data['postCommentCount'],
              //                             parentContext: context,
              //                           );
              //                         }).toList(),
              //                       );
              //                     },
              //                     childCount: posts.length,
              //                   ),
              //                 )
              //               : Container(
              //                   child: Center(
              //                       child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: <Widget>[
              //                       Icon(
              //                         Icons.error,
              //                         color: Colors.grey[700],
              //                         size: 64,
              //                       ),
              //                       Padding(
              //                         padding: const EdgeInsets.all(14.0),
              //                         child: Text(
              //                           'There is no post',
              //                           style: TextStyle(
              //                               fontSize: 16,
              //                               color: Colors.grey[700]),
              //                           textAlign: TextAlign.center,
              //                         ),
              //                       ),
              //                     ],
              //                   )),
              //                 ),
              //           Utils.loadingCircle(_isLoading),
              //         ],
              //       );

              //       // PostContainer(data: data,myData: widget.myData,updateMyDataToMain: widget.updateMyData,threadItemAction: _moveToContentDetail,isFromThread:true,commentCount: data['postCommentCount'],parentContext: context,);
              //     }),
            ],
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            // child: Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: ContactsList(users: Userss),
            // ),
          ),
        ),
      ],
    );
  }

//   void _moveToContentDetail(DocumentSnapshot data) {
//     Navigator.push(
//         Get.context,
//         MaterialPageRoute(
//             builder: (context) => ContentDetail(
//                   postData: data,
//                   myData: currentUser.value,
//                   updateMyData: updateMyData,
//                 )));
//   }
}
