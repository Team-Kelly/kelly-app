import 'package:app/util/coordinates.vo.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CoordinatesDTO {
  static Future<CoordinatesVO> get(
      {required String? admCd,
      required String? rnMgtSn,
      required String? udrtYn,
      required String? buldMnnm,
      required String? buldSlno}) async {
    final http.Response response = await http.get(
      Uri.parse(
          'https://www.juso.go.kr/addrlink/addrCoordApi.do?confmKey=devU01TX0FVVEgyMDIyMDMwNjEzNTExNjExMjMxNDg%3D&resultType=json' +
              '&admCd=' +
              admCd! +
              '&rnMgtSn=' +
              rnMgtSn! +
              '&udrtYn=' +
              udrtYn! +
              '&buldMnnm=' +
              buldMnnm! +
              '&buldSlno=' +
              buldSlno!),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return CoordinatesVO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to load data...${response.statusCode}');
    }
  }
}
