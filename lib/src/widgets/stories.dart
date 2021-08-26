import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import '../elements/StoryCarouselLoaderWidget.dart';
import '../models/userstories.dart';
import '../elements/social/utils.dart';
import '../controllers/user_stories_controller.dart';
import '../models/user.dart';
import '../repository/user_repository.dart';
import 'user_post_avatar.dart';
import '../soconfig/pallete.dart';
import '../widgets/widgets.dart';

class Stories extends StatelessWidget {
  const Stories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: GetX<UserStoriesController>(
          init: Get.put<UserStoriesController>(UserStoriesController()),
          builder: (UserStoriesController userstoriesController) {
            if (userstoriesController != null &&
                userstoriesController.userstories != null) {
              return LazyLoadingList(
                  initialSizeOfItems: 7,
                  index: userstoriesController.userstories.length,
                  hasMore: true,
                  loadMore: () => StoriesCarouselLoaderWidget(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 8.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: userstoriesController.userstories.length,
                    itemBuilder: (BuildContext context, int index) {
                      var userdataid = userstoriesController.userstories
                          .map((e) => e.storyuserid);
                      var userdatatimestamp = userstoriesController.userstories
                          .map((e) => e.first_story_timestamp);
                      var usertimestamp = userdatatimestamp.toList();
                      var userid = userdataid.toList();
                      print(usertimestamp);
                      for (var usertimestampsingle in usertimestamp)
                        if (userid != currentUser.value.id ||
                            Utils.readTimestamp(usertimestampsingle) == '1d' ||
                            usertimestampsingle == 'NONE') {
                          print('NO STORIES');
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: _StoryCard(
                              isAddStory: true,
                              currentUser: currentUser,
                            ),
                          );
                        }
                      final StoriesuserModel story =
                          userstoriesController.userstories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _StoryCard(story: story),
                      );
                    },
                  ));
            } else {
              return StoriesCarouselLoaderWidget();
            }
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final ValueNotifier<Userss> currentUser;
  final StoriesuserModel story;

  const _StoryCard({
    Key key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
  }) : super(key: key);

  static bool isStoryViewed = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: GestureDetector(
              onTap: () => isAddStory
                  ? Navigator.of(context).pushNamed(
                      '/CreateStories',
                    )
                  : Navigator.of(context).pushNamed(
                      '/ViewStories',
                    ),
              child: CachedNetworkImage(
                imageUrl: isAddStory
                    ? currentUser.value.image.thumb
                    : story.first_story_image,
                height: double.infinity,
                width: 110.0,
                fit: BoxFit.cover,
              )),
        ),
        Container(
          height: double.infinity,
          width: 110.0,
          decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: Responsive.isDesktop(context)
                ? const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 4.0,
                    ),
                  ]
                : null,
          ),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: isAddStory
              ? Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add),
                    iconSize: 30.0,
                    color: Palette.facebookBlue,
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/CreateStories',
                    ),
                  ),
                )
              : UserPostAvatar(
                  hasBorder: !isStoryViewed,
                  story: story,
                ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: GestureDetector(
              onTap: () => isAddStory
                  ? Navigator.of(context).pushNamed(
                      '/CreateStories',
                    )
                  : Navigator.of(context).pushNamed(
                      '/ViewStories',
                    ),
              child: Text(
                isAddStory ? 'Add to Story' : story.user_name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
        ),
      ],
    );
  }
}
