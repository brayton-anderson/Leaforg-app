import 'dart:async' show Future;
//import 'dart:html' as webFile;
import 'dart:io';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart'
    show BuildContext;
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';

Future takeCompressedPicture(BuildContext context) async {
  final temp = (await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50));
  final _imageFile = await temp.readAsBytes();
  //final image = Uint8List.fromList(_imageFile);
 // webFile.File _imageFile =  webFile.File(temp.path);
  // ImageProvider provider = MemoryImage(Uint8List.fromList(_imageFile));
  // var _imageFileresult = await FlutterImageCompress.compressWithList(
  //   image,
  //   minHeight: 500,
  //   minWidth: 262,
  //   quality: 70,
  //   rotate: 0,
  //   autoCorrectionAngle: true,
  //   format: CompressFormat.jpeg,
  // );

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
