import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import '../helpers/image_upload_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/helper.dart';

class ImageUploadController extends GetxController {
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
    // else {
    //   Get.snackbar('Error', 'No image selected',
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: errorColor,
    //       colorText: Colors.white);
    // }
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void uploadImage(File file) {
    Overlay.of(Get.overlayContext).insert(loader);
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    ImageUploadProvider().uploadImage(file).then((resp) {
      Get.back();
      if (resp == "success") {
        Get.snackbar('Success', 'File Uploaded',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: successColor,
            colorText: Colors.white);
      } else if (resp == "fail") {
        Get.snackbar('Error', 'File upload failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: errorColor,
            colorText: Colors.white);
      }
    }, onError: (err) {
      Get.back();
      Get.snackbar('Error', 'File upload failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColor,
          colorText: Colors.white);
    });
  }

  void profileImageUpload( mediaData) async {
    // Overlay.of(context).insert(loader);
    //ImagePicker imagePicker = ImagePicker();
    Overlay.of(Get.overlayContext).insert(loader);

    if (null == mediaData) {
      loader.remove();
      Get.snackbar(
        "Hi, Sorry",
        "ACL",
        showProgressIndicator: false,
        duration: Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        maxWidth: MediaQuery.of(Get.context).size.width - 200,
        backgroundColor: infoColor,
        messageText: Text(
          'Image is not selected',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    } else {
      String base64Image = base64Encode(mediaData.data);
      String fileName = mediaData.fileName.split('/').last;
      // repository
      //     .uploadProfilePic(
      //         fileName,
      //         base64Image)
      //     .then((value) {
      //   if (null == null) {
      //     loader.remove();
      //     Get.snackbar(
      //       "Hi,",
      //       "ACL",
      //       showProgressIndicator: false,
      //       duration: Duration(seconds: 3),
      //       snackStyle: SnackStyle.FLOATING,
      //       maxWidth: MediaQuery.of(Get.context).size.width - 200,
      //       backgroundColor: successColor,
      //       messageText: Text(
      //         'Profile Image Uploaded',
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 15,
      //             fontWeight: FontWeight.w500),
      //       ),
      //     );
      //   } else {
      //     loader.remove();
      //     Get.snackbar(
      //       "Hi, Sorry",
      //       "ACL",
      //       showProgressIndicator: false,
      //       duration: Duration(seconds: 3),
      //       snackStyle: SnackStyle.FLOATING,
      //       maxWidth: MediaQuery.of(Get.context).size.width - 200,
      //       backgroundColor: errorColor,
      //       messageText: Text(
      //         'Profile Image Upload Failed',
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 15,
      //             fontWeight: FontWeight.w500),
      //       ),
      //     );
      //   }
      // }).catchError((e) {
      //   loader.remove();
      //   Get.snackbar(
      //     "Hi, Sorry",
      //     "ACL",
      //     showProgressIndicator: false,
      //     duration: Duration(seconds: 3),
      //     snackStyle: SnackStyle.FLOATING,
      //     maxWidth: MediaQuery.of(Get.context).size.width - 200,
      //     backgroundColor: errorColor,
      //     messageText: Text(
      //       'Profile Image Upload Failed',
      //       style: TextStyle(
      //           color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      //     ),
      //   );
      // }).whenComplete(() {
      //   Helper.hideLoader(loader);
      // });
    }
  }
}
