class Location {
  final double latitude;
  final double longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Location(latitude: parsedJson['lat'], longitude: parsedJson['lng']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
