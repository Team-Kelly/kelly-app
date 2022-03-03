import 'dart:convert';
import 'package:http/http.dart' as http;

Future getRoutes() async {
  String endX = 127.0979449.toString();
  String endY = 37.5132612.toString();
  String option = 0.toString();
  String startX = 127.2864968.toString();
  String startY = 37.6561733.toString();

  final http.Response response = await http.post(
    Uri.parse('http://ssh.doky.space:8081/api/navi/route'),
    headers: {"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{
      "endX": endX,
      "endY": endY,
      "option": option,
      "startX": startX,
      "startY": startY
    }),
  );

  if (response.statusCode == 200) {
    List result = jsonDecode(utf8.decode(response.bodyBytes));
    print(result[0]);
    print(result[0].runtimeType);
    print(response.statusCode);
    print(result[0]['pathNodeList'][0]['startStationName']);
    print(result[0]['pathNodeList'][0]['endStationName']);
    return Result(routes: jsonDecode(response.body));
  } else {
    throw Exception('Loading data...${response.statusCode}');
  }
}

Future getWeather() async {
  double lat = 37.6576769;
  double lon = 127.3007637;

  final http.Response response = await http.post(
    Uri.parse('http://ssh.doky.space:8081/api/category/weather/oneday'),
    headers: {"Content-Type": "application/json"},
    body: json.encode(<String, dynamic>{"lat": lat, "lon": lon}),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
    print(result['skyStatusDetail']);
    print(response.statusCode);
    // return Result(routes: jsonDecode(response.body));
  } else {
    throw Exception('Loading data...${response.statusCode}');
  }
}

class Result {
  late List routes;
  Result({required this.routes});
}
