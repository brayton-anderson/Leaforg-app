import 'dart:io';
import 'dart:math' as Math;
import 'package:image/image.dart' as Im;

import 'package:emoji_chooser/emoji_chooser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import '../../elements/social/add_to_post.dart';
import '../../models/data_models.dart';
import '../../widgets/widgets.dart';

class CreatePostDialogController extends GetxController {
  TextEditingController postEditingController;
  var selectedPriority = 1.obs;
  var writterBegan = 15.obs;
  var resizeforEmoji = 10.obs;
  var isProcessing = false.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  OverlayEntry loader;
  RxBool loading = false.obs;

  var infoColor = Color(0xFFFFC001);
  var errorColor = Color(0xFFDE3F44);
  var successColor = Theme.of(Get.context).secondaryHeaderColor;
  EmojiData _emojiData;
  User myData;
  CreatePostDialogController();

  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    // getTask(page);

    // //For Pagination
    // paginateTask();

    // To Save  Task
    postEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<File> getcropImage(image) async {
    // final pickedFile = await ImagePicker().pickImage(source: imageSource);
    // if (pickedFile != null) {
    //   selectedImagePath.value = pickedFile.path;
    //   selectedImageSize.value =
    //       ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
    //               .toStringAsFixed(2) +
    //           " Mb";

    // Crop
    final cropImageFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: defaultTargetPlatform == TargetPlatform.android
            ? AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.blue[800],
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false)
            : null,
        iosUiSettings: defaultTargetPlatform == TargetPlatform.iOS
            ? IOSUiSettings(
                title: 'Cropper',
              )
            : null,
        compressFormat: ImageCompressFormat.jpg);
    cropImagePath.value = cropImageFile.path;
    cropImageSize.value =
        ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
                .toStringAsFixed(2) +
            " Mb";

    // Compress

    final dir = await Directory.systemTemp;
    final targetPath = dir.absolute.path + "/temp.jpg";
    var compressedFile = await FlutterImageCompress.compressAndGetFile(
        cropImagePath.value, targetPath,
        quality: 90);
    compressImagePath.value = compressedFile.path;
    compressImageSize.value =
        ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
                .toStringAsFixed(2) +
            " Mb";

    return compressedFile;
  }

  Future<File> getcropwebImage(paths, imagesss) async {
    // cropImagePath.value = image;
    // cropImageSize.value =
    //     ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
    //             .toStringAsFixed(2) +
    //         " Mb";

    // Compress
    //  String finalpath = paths;
    // final tempDir = await getTemporaryDirectory();
    // final path = tempDir.path;
    int rand = new Math.Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imagesss);
    Im.Image smallerImage = Im.copyResize(
        image); // choose the size here, it will maintain aspect ratio

    var compressedImage = new File('${paths}/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 55));

    // final dir = await Directory.systemTemp;
    // final targetPath = dir.absolute.path + "/temp.jpg";
    // var compressedFile = await FlutterImageCompress.compressAndGetFile(
    //     image, targetPath,
    //     quality: 50);
    // compressImagePath.value = compressedFile.path;
    // compressImageSize.value =
    //     ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
    //             .toStringAsFixed(2) +
    //         " Mb";

    return compressedImage;
    //File.fromRawPath(result);
  }

  // createtype, fomattype, repository_type
  void OpenCreateBox() {
    final mediaQuery = MediaQuery.of(Get.context).size;
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      titleStyle: TextStyle(
        color: Theme.of(Get.context).shadowColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.only(
          top: 3,
          bottom: 15,
        ),
        constraints: BoxConstraints(
          minHeight: 480,
          maxHeight: double.infinity,
          minWidth: 620,
          maxWidth: 620,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(Get.context).focusColor.withOpacity(0.2),
                blurRadius: 15,
                offset: Offset(0, 5)),
          ],
          color: Theme.of(Get.context).primaryColor,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 67,
                constraints: BoxConstraints(
                  minHeight: 67,
                  maxHeight: 67,
                  minWidth: 620,
                  maxWidth: 620,
                ),
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Create Post',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(Get.context).splashColor,
                                  ),
                                ),
                              ]),
                          SizedBox(
                            width: 390,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CircleButton(
                                  icon: PhosphorIcons.x_fill,
                                  iconSize: 26.0,
                                  onPressed: () => Navigator.pop(Get.context),
                                ),
                              ]),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Divider(height: 10.0, thickness: 0.5),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 80,
                color: Colors.transparent,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                constraints: BoxConstraints(
                  minHeight: 80,
                  maxHeight: 80,
                  minWidth: 620,
                  maxWidth: 620,
                ),
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return PostPrivacyUserCard();
                    }

                    return Center(
                      child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 0,
                            width: 0,
                          )),
                    );
                  },
                ),
              ),
              WritePost(),
            ]),
      ),
    );
  }
}
