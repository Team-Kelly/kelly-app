import 'package:app/util/weather.vo.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDTO {
  static Future<WeatherVO> get({
    required double latitude,
    required double longitude,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('http://ssh.doky.space:8081/api/category/weather/oneday'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(<String, dynamic>{"lat": latitude, "lon": longitude}),
    );

    if (response.statusCode == 200) {
      // Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      return WeatherVO(result: jsonDecode(utf8.decode(response.bodyBytes))
          // rainProb: result['rainProb'],
          // rainStatusCode: result['rainStatusCode'],
          // rainStatusDetail: result['rainStatusDetail'],
          // skyStatusCode: result['skyStatusCode'],
          // skyStatusDetail: result['skyStatusDetail'],
          // temp: result['temp'],
          // weatherStatusCode: result['weatherStatusCode'],
          // weatherStatusDetail: result['weatherStatusDetail']
          );
    } else {
      throw Exception('Fail to load data...${response.statusCode}');
    }
  }
}
