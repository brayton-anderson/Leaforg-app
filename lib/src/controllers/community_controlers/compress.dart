import 'dart:async' show Future;
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart' show BuildContext;
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';

Future<File> takeCompressedPicture(BuildContext context) async {
  final temp = (await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50));
  File _imageFile = File(temp.path);
  //final imageForSendToAPI = await temp.readAsBytes();
  // final _imagexFile =
  //     await ImagePicker().pickImage(source: ImageSource.gallery);
  // File _imageFile = File(_imagexFile.path);
  // // File _imageFile = convertToFile(_image);
  // if (_imageFile == null) {
  //   return null;
  // }

  //final tempDir = await getTemporaryDirectory();
  // final rand = Math.Random().nextInt(10000);
  // _CompressObject compressObject =
  //     _CompressObject(_imageFile, _imagexFile.path, rand);
  // String filePath = await _compressImage(compressObject);
  // print('new path: ' + filePath);
  // File file = File(filePath);

  // Pop loading

  return _imageFile;
}

Future<String> _compressImage(_CompressObject object) async {
  return compute(_decodeImage, object);
}

String _decodeImage(_CompressObject object) {
  Im.Image image = Im.decodeImage(object.imageFile.readAsBytesSync());
  Im.Image smallerImage = Im.copyResize(
      image); // choose the size here, it will maintain aspect ratio
  var decodedImageFile = File(object.path + '/img_${object.rand}.jpg');
  decodedImageFile.writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 85));
  return decodedImageFile.path;
}

class _CompressObject {
  File imageFile;
  String path;
  int rand;

  _CompressObject(this.imageFile, this.path, this.rand);
}
