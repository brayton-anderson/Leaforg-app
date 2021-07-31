import 'dart:io';
import 'dart:math';
import 'dart:html' as webhtml;

import 'dart:math' as Math;
import 'package:image/image.dart' as Im;

import 'package:emoji_chooser/emoji_chooser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/community_controlers/compress.dart';
import 'package:path_provider/path_provider.dart';
import 'utils.dart';
import '../../helpers/FBCloudStore.dart';
import '../../helpers/FBStorage.dart';
import '../../controllers/community_controlers/create_postsandstories_dialog.dart';
import '../../models/user.dart';

class WritePost extends StatefulWidget {
  final Userss myData;
  WritePost({this.myData});
  @override
  State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<WritePost> {
  final controller = Get.put(CreatePostDialogController());
  TextEditingController writingTextController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  bool _isLoading = false;
  File _postImageFile;
  EmojiData _emojiData;
  var writterBegan = 15.obs;
  var resizeforEmoji = 10.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: resizeforEmoji == 10.obs ? 140 : 50,
          width: 620,
          constraints: BoxConstraints(
            minHeight: resizeforEmoji == 10.obs ? 140 : 50,
            maxHeight: double.infinity,
            minWidth: 620,
            maxWidth: 620,
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Colors.transparent,
          child: ListView(
            children: [
              SizedBox(
                height: resizeforEmoji == 10.obs ? 120 : 30,
                child: TextField(
                  autofocus: true,
                  controller: controller.postEditingController,
                  style: TextStyle(fontSize: 15.0).copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                  decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(fontSize: 24.0).copyWith(
                          color: Colors.black26, fontWeight: FontWeight.w500)),
                ),
              ),
              resizeforEmoji == 10.obs
                  ? _postImageFile != null
                      ? kIsWeb == true
                          ? Image.network(
                              _postImageFile.path,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              _postImageFile,
                              fit: BoxFit.fill,
                            )
                      : Container()
                  // Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(10)),
                  //         color: Colors.transparent),
                  //   )
                  : Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      child: EmojiChooser(
                        onSelected: (emoji) {
                          setState(() {
                            _emojiData = emoji;
                            controller.postEditingController.text =
                                controller.postEditingController.text +
                                    emoji.char;
                          });
                          //resizeforEmoji = 10.obs;
                        },
                      ),
                    ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              height: 15,
              padding: EdgeInsets.only(left: 20, right: 20),
              color: Colors.transparent,
              child: resizeforEmoji == 11.obs
                  ? GestureDetector(
                      onTap: () => resizeforEmoji = 10.obs,
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0).copyWith(
                            color: Colors.black45, fontWeight: FontWeight.w400),
                      ))
                  : GestureDetector(
                      onTap: () => resizeforEmoji = 11.obs,
                      child: Icon(
                        PhosphorIcons.smiley_wink_light,
                        color: Colors.black38,
                      )),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 55,
              padding: EdgeInsets.only(left: 13, right: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(
                    width: 0.8,
                    color: Theme.of(context).splashColor.withOpacity(0.4)),
                color: Colors.transparent,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Add To Your Post',
                      style: const TextStyle(fontSize: 16.0).copyWith(
                          color: Theme.of(context).splashColor,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 190,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Select Image');
                        _getImageAndCrop();
                      },
                      child: Icon(
                        PhosphorIcons.image_fill,
                        color: Color(0xFFFFAA00),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      PhosphorIcons.video_camera_fill,
                      color: Colors.green,
                      size: 30,
                    ),
                    //const VerticalDivider(width: 8.0),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      PhosphorIcons.smiley_fill,
                      color: Colors.purpleAccent,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      PhosphorIcons.map_pin_fill,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      PhosphorIcons.dots_three_outline_fill,
                      color: Colors.black54,
                      size: 30,
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: GestureDetector(
              onTap: () => _postToFB(),
              child: Container(
                height: 45,
                padding: EdgeInsets.only(left: 13, right: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  boxShadow: [
                    BoxShadow(
                        color:
                            Theme.of(Get.context).focusColor.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 5)),
                  ],
                  color: controller.postEditingController != ''
                      ? Theme.of(context).secondaryHeaderColor
                      : Colors.black38,
                ),
                child: Center(
                  child: Text(
                    'Post',
                    style: const TextStyle(fontSize: 16.0).copyWith(
                        color: controller.postEditingController != ''
                            ? Colors.white
                            : Theme.of(Get.context)
                                .splashColor
                                .withOpacity(0.4),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  void _postToFB() async {
    setState(() {
      _isLoading = true;
    });
    String postID = Utils.getRandomString(8) + Random().nextInt(500).toString();
    String postImageURL;
    if (_postImageFile != null) {
      print('objectnanana');
      postImageURL = await FBStorage.uploadPostImages(
          postID: postID, postImageFile: _postImageFile);
    }
    FBCloudStore.sendPostInFirebase(
        postID,
        controller.postEditingController.text,
        widget.myData,
        postImageURL ?? 'NONE');

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  Future<void> _getImageAndCrop() async {
    // choose the size here, it will maintain aspect ratio
    // webhtml.InputElement uploadInput = webhtml.FileUploadInputElement()
    //   ..accept = 'image/*';
    // uploadInput.click();

    // // uploadInput.onChange.listen((event) {
    // //   final file = uploadInput.files.first;
    // //   final reader = webhtml.FileReader();
    // //   reader.readAsDataUrl(file);
    // //   reader.onLoadEnd.listen((event) async {
    File cropImageFile = await takeCompressedPicture(context);
    if (cropImageFile != null) {
      setState(() {
        _postImageFile = cropImageFile;
        Get.snackbar('hello', 'hello');
      });
    }
    //    });
    //  });

    //await getcropImage cropImageFile(imageFileFromGallery);
  } // Some web specific code there
}
