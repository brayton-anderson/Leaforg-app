import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import '../repository/user_repository.dart';
import '../controllers/community_controlers/create_postsandstories_dialog.dart';
import '../widgets/widgets.dart';

class PostPrivacyUserCard extends GetView<CreatePostDialogController> {
  const PostPrivacyUserCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(),
          const SizedBox(width: 6.0),
          Container(
            width: 180,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              border: Border.all(
                  width: 0.5,
                  color: Theme.of(context).splashColor.withOpacity(0.4)),
              color: Colors.transparent,
            ),
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      PhosphorIcons.globe_hemisphere_west_fill,
                      size: 20,
                      color: Theme.of(context).splashColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      currentUser.value.name,
                      style: const TextStyle(fontSize: 16.0).copyWith(
                          color: Theme.of(context).splashColor,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
          ),
          const SizedBox(width: 6.0),
          Container(
            width: 180,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              border: Border.all(
                  width: 0.8,
                  color: Theme.of(context).splashColor.withOpacity(0.4)),
              color: Colors.transparent,
            ),
            child: Center(
              child: SizedBox(
                width: 180,
                height: 35,
                child: Obx(() => DropdownButton<String>(
                      focusColor: Colors.transparent,
                      // borderRadius: BorderRadius.all(Radius.circular(10)),
                      underline: SizedBox(),
                      // Set the Items of DropDownButton
                      items: [
                        DropdownMenuItem(
                          value: "1",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                PhosphorIcons.globe_hemisphere_west_fill,
                                size: 20,
                                color: Theme.of(context).splashColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Anyone",
                                style: const TextStyle(fontSize: 16.0).copyWith(
                                    color: Theme.of(context).splashColor,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.fade),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "2",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                PhosphorIcons.users_three_fill,
                                size: 20,
                                color: Theme.of(context).splashColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Friends only",
                                style: const TextStyle(fontSize: 16.0).copyWith(
                                    color: Theme.of(context).splashColor,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.fade),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "3",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                PhosphorIcons.user_fill,
                                size: 20,
                                color: Theme.of(context).splashColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Only me",
                                style: const TextStyle(fontSize: 16.0).copyWith(
                                    color: Theme.of(context).splashColor,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.fade),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                      value: controller.selectedPriority.value.toString(),
                      hint: Text('Share this post with?'),
                      isExpanded: true,
                      onChanged: (selectedValue) {
                        controller.selectedPriority.value =
                            int.parse(selectedValue);
                      },
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
