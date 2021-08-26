import 'dart:math';
import 'package:emoji_chooser/emoji_chooser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'const.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import '../../helpers/snackbar_notifications.dart';
import '../../controllers/community_controlers/compress.dart';
import 'utils.dart';
import '../../helpers/FBCloudStore.dart';
import 'package:firebase/firebase.dart' as fb;
import '../../helpers/FBStorage.dart';
import '../../controllers/community_controlers/create_postsandstories_dialog.dart';

class WritePost extends StatefulWidget {
  final MyProfileData myData;
  WritePost({this.myData});
  @override
  State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<WritePost> with SingleTickerProviderStateMixin {
  final controller = Get.put(CreatePostDialogController());
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  bool _isLoading = false;
  var _postImageFile;
  fb.UploadTask task;
  static String postImageURL;
  // UploadTask? task;
  EmojiData _emojiData;
  var writterBegan = 15.obs;
  var resizeforEmoji = 10.obs;
  double _inputHeight = 50;

  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    controller.postEditingController.addListener(_checkInputHeight);
    super.initState();
  }

  void _checkInputHeight() async {
    int count = controller.postEditingController.text.split('\n').length;

    if (count == 0 && _inputHeight == 50.0) {
      return;
    }
    if (count <= 5) {
      // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }
  }

  @override
  void dispose() {
    controller.postEditingController.dispose();
    super.dispose();
  }

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
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  style: TextStyle(fontSize: 15.0).copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                  decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(fontSize: 24.0).copyWith(
                          color: Colors.black26, fontWeight: FontWeight.w500)),
                ),
              ),
              _postImageFile != null
                  ? kIsWeb == true
                      ? Image.memory(
                          _postImageFile,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(
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
              child: GestureDetector(
                  onTap: () {
                    emojichooser(context);
                    setState(() {
                      resizeforEmoji = 11.obs;
                    });
                  },
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
        task != null
            ? buildUploadStatus(task)
            : Padding(
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
                              color: Theme.of(Get.context)
                                  .focusColor
                                  .withOpacity(0.2),
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

    if (_postImageFile != null) {
      print('objectnanana');
      task = await FBStorage.uploadPostImages(
          postID: postID, postImageFile: _postImageFile);
      setState(() {});

      if (task == null) return;
      final snapshot = await task;
      final urlDownload = await snapshot.future;
      var imageUri = await urlDownload.ref.getDownloadURL();
      String url = imageUri.toString();
      setState(() {
        postImageURL = url;
      });
    }
    if (postImageURL != null) {
      FBCloudStore.sendPostInFirebase(postID,
          controller.postEditingController.text, widget.myData, postImageURL);
      setState(() {
        controller.postEditingController.clear();
      });
    } else {
      final messages = 'Post cant be uploaded';
      final button = "";
      final route = "";
      final request = "error_snack";

      getSnackbarNotification(messages, request, button, route);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  Future emojichooser(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext subcontext) {
        return Container(
          height: 266,
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: 15,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  color: Colors.transparent,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(subcontext).pop();
                        setState(() {
                          resizeforEmoji = 10.obs;
                        });
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0).copyWith(
                            color: Colors.black45, fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ),
            EmojiChooser(
              columns: 10,
              rows: 5,
              onSelected: (emoji) {
                setState(() {
                  _emojiData = emoji;
                  controller.postEditingController.text =
                      controller.postEditingController.text + emoji.char;
                });
                // Navigator.of(subcontext).pop(emoji);
              },
            ),
          ]),
        );
      },
    );
  }

  Widget buildUploadStatus(fb.UploadTask task) =>
      StreamBuilder<fb.UploadTaskSnapshot>(
        stream: task.onStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final transferredsnapkb =
                (snap.bytesTransferred / 1024).toStringAsFixed(2);
            final transferredsnapmb =
                (snap.bytesTransferred / 1048576).toStringAsFixed(2);
            final totalsnapkeb = (snap.totalBytes / 1024).toStringAsFixed(2);
            final totalsnapmb = (snap.totalBytes * 100).roundToDouble();
            final progress = snap.bytesTransferred / snap.totalBytes;
            final stringpercentage = (progress * 100).roundToDouble();
            final percentage = (snap.bytesTransferred * 100).roundToDouble();

            return Center(
                child: Container(
              width: 70,
              height: 70,
              color: Colors.transparent,
              child:

                  // Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  // SizedBox(
                  //   height: 10,
                  // ),

                  SquarePercentIndicator(
                width: 70,
                height: 70,
                startAngle: StartAngle.topRight,
                // startAngle: StartAngle.bottomRight,
                reverse: true,
                borderRadius: 7,
                shadowWidth: 0.8,
                progressWidth: 4,
                shadowColor: Colors.grey,
                progressColor: stringpercentage >= 86
                    ? Theme.of(context).hintColor
                    : stringpercentage >= 50
                        ? Theme.of(context).secondaryHeaderColor
                        : Colors.redAccent,
                progress: percentage / totalsnapmb,
                child: Center(
                    child: Text(
                  "${stringpercentage.toString()} %",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: stringpercentage >= 86
                        ? Theme.of(context).hintColor
                        : stringpercentage >= 50
                            ? Theme.of(context).secondaryHeaderColor
                            : Colors.redAccent,
                  ),
                )),
              ),
              //     CircularPercentIndicator(
              //   radius: 50.0,
              //   lineWidth: 5.0,
              //   animation: true,
              //   percent: percentage,
              //   center: Text(
              //     percentage.toString() + "%",
              //     style: TextStyle(
              //       fontSize: 12.0,
              //       fontWeight: FontWeight.w600,
              //       color: percentage >= 86.0
              //           ? Theme.of(context).hintColor
              //           : percentage >= 50.0
              //               ? Theme.of(context).secondaryHeaderColor
              //               : Colors.redAccent,
              //     ),
              //   ),
              //   backgroundColor: Colors.grey[300],
              //   circularStrokeCap: CircularStrokeCap.round,
              //   progressColor: percentage >= 86.0
              //       ? Theme.of(context).hintColor
              //       : percentage >= 50.0
              //           ? Theme.of(context).secondaryHeaderColor
              //           : Colors.redAccent,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       SizedBox(
              //         width: 20,
              //       ),
              //       //1048576
              //       Text(
              //         'sent: ',
              //         style: const TextStyle(fontSize: 16.0).copyWith(
              //             color: percentage >= 86.0
              //                 ? Theme.of(context).hintColor
              //                 : percentage >= 50.0
              //                     ? Theme.of(context).secondaryHeaderColor
              //                     : Colors.redAccent,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text(
              //         snap.bytesTransferred / 1024 >= 1024
              //             ? transferredsnapmb
              //             : transferredsnapkb,
              //         style: const TextStyle(fontSize: 16.0).copyWith(
              //             color: percentage >= 86.0
              //                 ? Theme.of(context).hintColor
              //                 : percentage >= 50.0
              //                     ? Theme.of(context).secondaryHeaderColor
              //                     : Colors.redAccent,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         '/',
              //         style: const TextStyle(fontSize: 16.0).copyWith(
              //             color: Theme.of(Get.context)
              //                 .splashColor
              //                 .withOpacity(0.8),
              //             fontWeight: FontWeight.w500),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         snap.totalBytes / 1024 >= 1024
              //             ? totalsnapmb
              //             : totalsnapkeb,
              //         style: const TextStyle(fontSize: 16.0).copyWith(
              //             color: Theme.of(Get.context)
              //                 .hintColor
              //                 .withOpacity(0.8),
              //             fontWeight: FontWeight.w500),
              //       ),
              //       SizedBox(
              //         width: 20,
              //       ),
              //     ]),
              // ]),
            ));

            // Text(
            //   '$percentage %',
            //   style: const TextStyle(fontSize: 16.0).copyWith(
            //       color: Theme.of(Get.context).splashColor.withOpacity(0.4),
            //       fontWeight: FontWeight.w500),
            // );
          } else {
            return Container();
          }
        },
      );

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
    final cropImageFile = await takeCompressedPicture(context);
    if (cropImageFile != null) {
      setState(() {
        _postImageFile = cropImageFile;
        final messages = 'Image has been uploaded';
        final button = "";
        final route = "";
        final request = "success_snack";

        getSnackbarNotification(messages, request, button, route);
      });
    }
    //    });
    //  });

    //await getcropImage cropImageFile(imageFileFromGallery);
  }

  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  //   if (result == null) return;
  //   final path = result.files.single.path!;

  //   setState(() => file = File(path));
  // }// Some web specific code there
}
