import '../helpers/custom_trace.dart';
import '../models/media.dart';

class Userss {
  String id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String dateofbirth;
  String gender;
  String agreement;
  String address;
  String latitude;
  String longitude;
  String bio;
  Media image;
  List<String> myLikeList;
  List<String> myLikeCommnetList;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Userss(
      {this.name,
      this.email,
      this.apiToken,
      this.deviceToken,
      this.phone,
      this.address,
      this.gender,
      this.agreement,
      this.dateofbirth,
      this.bio,
      this.latitude,
      this.longitude,
      this.image,
      this.myLikeList,
      this.myLikeCommnetList});

  Userss.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      dateofbirth = jsonMap['dateofbirth'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      agreement = jsonMap['agreement'];
      gender = jsonMap['gender'];
      try {
        address = jsonMap['custom_fields']['address']['view'];
      } catch (e) {
        address = "";
      }
      try {
        bio = jsonMap['custom_fields']['bio']['view'];
      } catch (e) {
        bio = "";
      }
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["phone"] = phone;
    map["address"] = address;
    map["bio"] = bio;
    map["agreement"] = agreement;
    map["dateofbirth"] = dateofbirth;
    map["gender"] = gender;
    map["media"] = image?.toMap();
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool profileCompleted() {
    return address != null && address != '';
  }
}
