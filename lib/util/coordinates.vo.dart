class CoordinatesVO {
  Common common;
  List<Juso> jusoList;

  CoordinatesVO({
    required this.common,
    required this.jusoList,
  });

  factory CoordinatesVO.fromJson(Map<String, dynamic> json) {
    final results = json['results'];
    final common = Common.fromJson(results['common']);
    List<Juso> jusoList = [];
    if (results['juso'] != null) {
      final jusoJsonList = results['juso'] as List;
      jusoList = jusoJsonList.map((item) => Juso.fromJson(item)).toList();
    }

    return CoordinatesVO(
      common: common,
      jusoList: jusoList,
    );
  }
}

class Common {
  String errorMessage;
  String totalCount;
  String errorCode;

  Common(
      {required this.errorMessage,
      required this.totalCount,
      required this.errorCode});

  factory Common.fromJson(Map<String, dynamic> json) {
    return Common(
      errorMessage: json['errorMessage'],
      totalCount: json['totalCount'],
      errorCode: json['errorCode'],
    );
  }
}

class Juso {
  String buldMnnm;
  String rnMgtSn;
  String bdNm;
  String entX;
  String entY;
  String admCd;
  String bdMgtSn;
  String buldSlno;
  String udrtYn;

  Juso(
      {required this.buldMnnm,
      required this.rnMgtSn,
      required this.bdNm,
      required this.entX,
      required this.entY,
      required this.admCd,
      required this.bdMgtSn,
      required this.buldSlno,
      required this.udrtYn});

  factory Juso.fromJson(Map<String, dynamic> json) {
    return Juso(
      buldMnnm: json["buldMnnm"],
      rnMgtSn: json["rnMgtSn"],
      bdNm: json["bdNm"],
      entX: json["entX"],
      entY: json["entY"],
      admCd: json["admCd"],
      bdMgtSn: json["bdMgtSn"],
      buldSlno: json["buldSlno"],
      udrtYn: json["udrtYn"],
    );
  }
}
