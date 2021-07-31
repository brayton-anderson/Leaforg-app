import '../helpers/custom_trace.dart';

class HomesubiconPosition {
  String top;
  String bottom;
  String left;
  String right;

  HomesubiconPosition();

  HomesubiconPosition.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      top = jsonMap['top'].toString();
      bottom = jsonMap['bottom'].toString();
      left = jsonMap['left'].toString();
      right = jsonMap['right'].toString();
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["top"] = top;
    map["bottom"] = bottom;
    map["left"] = left;
    map["right"] = right;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}
