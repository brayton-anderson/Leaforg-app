import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import '../../controllers/user_stories_controller.dart';
import '../../elements/StoryCarouselLoaderWidget.dart';
import '../../models/userstories.dart';
import '../../widgets/widgets.dart';
import 'view_stories.dart';
import '../../helpers/responcive_app.dart' as devices;

class ViewStoriesPage extends StatefulWidget {
  final StoriesuserModel users;

  @override
  _ViewStoriesPageState createState() => _ViewStoriesPageState();
  const ViewStoriesPage({
    Key key,
    @required this.users,
  }) : super(key: key);
}

class _ViewStoriesPageState extends State<ViewStoriesPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      //key: _con.scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: mediaQuery.width,
          height: mediaQuery.height,
          color: Colors.black,
          child: devices.Responsive.isMobile(context)
              ? ViewStoriesScreen()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(20),
                      height: mediaQuery.height,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: 100,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  CircleButton(
                                    icon: PhosphorIcons.x_fill,
                                    iconSize: 30.0,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(height: 10.0, thickness: 0.5),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: mediaQuery.height - 180,
                              child: ListView(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Stories',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).splashColor),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Your Stories',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).splashColor),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      height: 100,
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () => print('Messenger'),
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                                color: Theme.of(context)
                                                    .splashColor
                                                    .withOpacity(0.03),
                                              ),
                                              child: Icon(
                                                PhosphorIcons.plus_fill,
                                                size: 30.0,
                                                color: Theme.of(context)
                                                    .splashColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Create a Story',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .splashColor),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Post a photo or write, whatever!',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .splashColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'All Stories',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).splashColor),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 600,
                                    color: Colors.transparent,
                                    child: Expanded(
                                      child: GetX<UserStoriesController>(
                                          init: Get.put<UserStoriesController>(
                                              UserStoriesController()),
                                          builder: (UserStoriesController
                                              userstoriesController) {
                                            if (userstoriesController != null &&
                                                userstoriesController
                                                        .userstories !=
                                                    null) {
                                              return LazyLoadingList(
                                                  initialSizeOfItems: 7,
                                                  index: userstoriesController
                                                      .userstories.length,
                                                  hasMore: true,
                                                  loadMore: () =>
                                                      StoriesCarouselLoaderWidget(),
                                                  child: ListView.builder(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10.0),
                                                    itemCount:
                                                        userstoriesController
                                                            .userstories.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final StoriesuserModel
                                                          user =
                                                          userstoriesController
                                                                  .userstories[
                                                              index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0),
                                                        child: UserCard(
                                                          users: user,
                                                        ),
                                                      );
                                                    },
                                                  ));
                                            } else {
                                              return StoriesCarouselLoaderWidget();
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                        width: mediaQuery.width - 400,
                        height: mediaQuery.height,
                        color: Colors.black,
                        child: Stack(alignment: Alignment.topCenter, children: [
                          SizedBox(
                            height: 25,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: mediaQuery.height - 150,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.1),
                                          blurRadius: 7,
                                          offset: Offset(0, 3)),
                                    ],
                                    color: Colors.black,
                                  ),
                                  child: ViewStoriesScreen(),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 60,
                                  width: 640,
                                  color: Colors.black,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.1),
                                                blurRadius: 7,
                                                offset: Offset(0, 3)),
                                          ],
                                          border: Border.all(
                                              width: 1.2,
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.8)),
                                          color: Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 7,
                                              ),
                                              // Icon(
                                              //   PhosphorIcons.magnifying_glass_light,
                                              //   size: 26,
                                              //   color: Theme.of(context).splashColor.withOpacity(0.5),
                                              // ),
                                              // SizedBox(
                                              //   width: 15,
                                              // ),
                                              Text('Comment',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.8),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ])
                        ])),
                  ],
                ),
        ),
      ),
    );
  }
}
