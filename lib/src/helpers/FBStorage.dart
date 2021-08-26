import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class FBStorage {
  static fb.UploadTask uploadPostImages({String postID, postImageFile}){
    print("postIageUff+L");

    //fb.UploadTaskSnapshot uploadTaskSnapshot;
    var bytes =  postImageFile;
    try {
      String fileName = 'images/$postID/postImage';
      fb.StorageReference _storage = fb.storage().ref(fileName);
      final uploadTask = _storage
          .put(bytes, fb.UploadMetadata(contentType: 'image/png'));
      // var imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
      // url = imageUri.toString();
      // print(url);
      //uploadTaskSnapshot
      return uploadTask;
    } on fb.FirebaseError catch (e) {
      print(e);
      return null;
    }
    // try {
    //      Uint8List imageBase64 = postImageFile.readAsBytesSync();
    // String imageAsString = base64Encode(imageBase64);
    // Uint8List uint8list = base64.decode(imageAsString);
    // Image imagess = Image(uint8list);

//  File('thumbnail.png').writeAsBytesSync(encodeJpg (imagess));
    //   print("postIageUff+jjjjjjL");
    //   String fileName = 'images/$postID/postImage';

    //   var reference = storage.ref().child(fileName);
    //   UploadTask uploadTask = reference.putFile(postImageFile);
    //   TaskSnapshot taskSnapshot = await uploadTask;
    //   taskSnapshot.ref.getDownloadURL().then((value) {
    //     return value;
    //   });
    // } catch (e) {
    //   return null;
    // }
  }
}
