import 'package:app/util/address.vo.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressDTO {
  static Future<AddressVO> get({
    required String? keyword,
  }) async {
    final http.Response response = await http.get(
      Uri.parse(
          'https://www.juso.go.kr/addrlink/addrLinkApi.do?confmKey=devU01TX0FVVEgyMDIyMDMwNjE0MjAzNjExMjMxNDk%3D&currentPage=1&countPerPage=10&resultType=json&keyword=' +
              keyword!),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return AddressVO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to load data...${response.statusCode}');
    }
  }
}
