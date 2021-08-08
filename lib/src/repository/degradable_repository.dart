import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/degradable.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';

Future<Stream<Degradable>> getDegradable() async {
  Uri uri = Helper.getUri('api/degradable/');
  //Map<String, dynamic> _queryParams = {};
  //uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    print(streamedRest);

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .map((data) => Degradable.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Degradable.fromJSON({}));
  }
}
