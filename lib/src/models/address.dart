import 'package:location/location.dart';
import '../models/geometry.dart';

import '../helpers/custom_trace.dart';

class Address {
  String id;
  Geometry geometry;
  String vicinity;
  String description;
  String name;
  String address;
  double latitude;
  double longitude;
  bool isDefault;
  String userId;

  Address();

  Address.fromJSON(
    Map<String, dynamic> jsonMap,
  ) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['formatted_address'] != null
          ? jsonMap['formatted_address'].toString()
          : null;
      vicinity =
          jsonMap['vicinity'] != null ? jsonMap['vicinity'].toString() : null;
      description = jsonMap['description'] != null
          ? jsonMap['description'].toString()
          : null;
      address = jsonMap['address'] != null ? jsonMap['address'] : null;
      latitude =
          jsonMap['latitude'] != null ? jsonMap['latitude'].toDouble() : null;
      longitude =
          jsonMap['longitude'] != null ? jsonMap['longitude'].toDouble() : null;
      isDefault = jsonMap['is_default'] ?? false;
      geometry = jsonMap['geometry'] != null &&
              (jsonMap['geometry'] as List).length > 0
          ? Geometry.fromJson(jsonMap['geometry'][0])
          : new Geometry();
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  bool isUnknown() {
    return latitude == null || longitude == null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["description"] = description;
    map["address"] = address;
    map["geometry"] = geometry;
    map["vicinity"] = vicinity;
    map["name"] = name;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["is_default"] = isDefault;
    map["user_id"] = userId;
    return map;
  }

  LocationData toLocationData() {
    return LocationData.fromMap({
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}
