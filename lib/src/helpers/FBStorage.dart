import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class FBStorage {
  static Future<String> uploadPostImages(
      {String postID, File postImageFile}) async {
    print("postIageUff+L");
    try {
  //      Uint8List imageBase64 = postImageFile.readAsBytesSync();
  // String imageAsString = base64Encode(imageBase64);
  // Uint8List uint8list = base64.decode(imageAsString);
  // Image imagess = Image(uint8list);

//  File('thumbnail.png').writeAsBytesSync(encodeJpg (imagess));
      print("postIageUff+jjjjjjL");
      String fileName = 'images/$postID/postImage';

      fb.StorageReference storageReference = fb.storage().ref().child(fileName);

      fb.UploadTaskSnapshot uploadTaskSnapshot =
          await storageReference.put(postImageFile).future;

      String postIageURL = await uploadTaskSnapshot.ref.getDownloadURL() as String;

      print(postIageURL);
      print("postIageUffffRL");
      return postIageURL;
    } catch (e) {
      return null;
    }
  }
}
