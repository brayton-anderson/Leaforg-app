import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:leaforgapp/src/repository/stories_repository.dart';
import '../controllers/community_controlers/create_postsandstories_dialog.dart';
import '../widgets/widgets.dart';

class CreatePostContainer extends GetView<CreatePostDialogController> {
  //final User myData;
  final controller = Get.put(CreatePostDialogController());

  CreatePostContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 5.0 : 0.0),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                // ProfileAvatar(imageUrl: currentUser.imageUrl),
                const SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.OpenCreateBox();
                      //print('nanana');
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'What\'s on your mind?',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 14.0).copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () => print('hello'),
                    icon: const Icon(
                      PhosphorIcons.image_fill,
                      color: Color(0xFFFFAA00),
                    ),
                    label: Text('Photo'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Video'),
                    icon: const Icon(
                      PhosphorIcons.video_camera_fill,
                      color: Colors.green,
                    ),
                    label: Text('Video'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Write article'),
                    icon: const Icon(
                      PhosphorIcons.article_fill,
                      color: Colors.purpleAccent,
                    ),
                    label: Text('Write article'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
