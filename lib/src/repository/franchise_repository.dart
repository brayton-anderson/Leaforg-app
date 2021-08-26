import 'dart:async';
import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../helpers/helper.dart';
import '../models/franchise.dart';

Future<Stream<Franchise>> getCuisines() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}franchises?orderBy=updated_at&sortedBy=desc';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
  .transform(utf8.decoder)
  .transform(json.decoder)
  .map((data) => Helper.getData(data))
  .expand((data) => (data as List))
  .map((data) {
    return Franchise.fromJSON(data);
  });
}
