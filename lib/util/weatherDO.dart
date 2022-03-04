import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDO {
  late List<dynamic> result;
  // late List<dynamic> rainProb;
  // late List<dynamic> rainStatusCode;
  // late List<dynamic> rainStatusDetail;
  // late List<dynamic> skyStatusCode;
  // late List<dynamic> skyStatusDetail;
  // late List<dynamic> temp;
  // late List<dynamic> weatherStatusCode;
  // late List<dynamic> weatherStatusDetail;

  WeatherDO({required this.result
      // required this.rainProb,
      // required this.rainStatusCode,
      // required this.rainStatusDetail,
      // required this.skyStatusCode,
      // required this.skyStatusDetail,
      // required this.temp,
      // required this.weatherStatusCode,
      // required this.weatherStatusDetail
      });
}

// DO, DTO 구조

class WeatherDTO {
  static Future<WeatherDO> getData(double latitude, double longitude) async {
    final http.Response response = await http.post(
      Uri.parse('http://ssh.doky.space:8081/api/category/weather/oneday'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(<String, dynamic>{"lat": latitude, "lon": longitude}),
    );

    if (response.statusCode == 200) {
      // Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      return WeatherDO(result: jsonDecode(utf8.decode(response.bodyBytes))
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
      throw Exception('Loading data...${response.statusCode}');
    }
  }
}
