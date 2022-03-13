import 'package:app/util/wment.vo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proj4dart/proj4dart.dart';

class WeatherMentionDTO {
  static Future<WeatherMentionVO> get({
    required Point location,
  }) async {
    Map<String, dynamic> raws = {};

    try {
      final http.Response response = await http.post(
        Uri.parse('http://ssh.doky.space:8081/api/category/weather/phrase'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(<String, dynamic>{
          "lat": location.x.toString(),
          "lon": location.y.toString(),
        }),
      );

      if (response.statusCode == 200) {
        raws = jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Fail to load data...${response.statusCode}');
      }
    } catch (err) {
      print(err);
    }

    return WeatherMentionVO(prop: [raws['phrase']]);
  }
}
