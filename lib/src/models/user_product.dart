import '../helpers/custom_trace.dart';
import '../models/media.dart';

class UserProduct {
  String id;
  String name;
  String bio;
  String phone;
  String address;
  String latitude;
  String longitude;
  Media image;

  UserProduct();

  UserProduct.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
      address = jsonMap['address'];
      bio = jsonMap['description'];
      phone = jsonMap['phone'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
    } catch (e) {
      id = '';
      name = '';
      image = new Media();
      address = '';
      latitude = '0';
      longitude = '0';
      bio = '';
      phone = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'store_cat_id': bio,
      'name': name,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
