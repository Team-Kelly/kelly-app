import 'package:app/util/address.vo.dart';
import 'package:app/util/address.dto.dart';
import 'package:app/util/coordinates.dto.dart';
import 'package:app/util/coordinates.vo.dart';
import 'package:app/view/alarm/select_path_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj4dart/proj4dart.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:app/util/utils.dart';

class SelectDestionationView extends StatefulWidget {
  const SelectDestionationView({Key? key}) : super(key: key);

  @override
  _SelectDestionationViewState createState() => _SelectDestionationViewState();
}

class _SelectDestionationViewState extends State<SelectDestionationView> {
  String startKeyword = '';
  String endKeyword = '';
  late AddressVO startAddress;
  late AddressVO endAddress;
  late CoordinatesVO startCoordinates;
  late CoordinatesVO endCoordinates;
  late Point startPoint;
  late Point endPoint;
  bool isWorking = false;

  Point transform(String x, String y) {
    var point = Point(x: double.parse(x), y: double.parse(y));
    var wgs84 = Projection.WGS84;
    var grs80 = Projection.get('EPSG:5179') ??
        Projection.add('EPSG:5179',
            '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs');
    var result = grs80.transform(wgs84, point);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8D8),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: const [
                        SizedBox(width: 6),
                        Icon(Icons.circle,
                            size: 7, color: CandyColors.candyPink),
                        SizedBox(width: 49),
                        Icon(Icons.circle,
                            size: 7, color: CandyColors.candyPink),
                      ],
                    ),
                    const Text(
                      '시작이 반이다',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                          color: CandyColors.candyPink),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                CandyTextField(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 83,
                  onChanged: (value) {
                    setState(() {
                      startKeyword = value!.trim();
                    });
                  },
                  prefixIcon: const Text(
                    '출발',
                    style: TextStyle(
                        color: CandyColors.candyPink,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  hintText: '내용을 입력해주세요!',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  elevation: 2,
                ),
                const SizedBox(height: 10),
                CandyTextField(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 83,
                  onChanged: (value) {
                    setState(() {
                      endKeyword = value!.trim();
                    });
                  },
                  prefixIcon: const Text(
                    '도착',
                    style: TextStyle(
                        color: CandyColors.candyPink,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  hintText: '내용을 입력해주세요!',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  elevation: 2,
                ),
                const SizedBox(height: 200),
                CandyButton(
                  width: MediaQuery.of(context).size.width - 60,
                  child: const Text(
                    '나의 시작길 입력하기',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  buttonColor: CandyColors.candyPink,
                  onPressed: (startKeyword.isNotEmpty &&
                          endKeyword.isNotEmpty &&
                          !isWorking)
                      ? work
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> work() async {
    isWorking = true;
    setState(() {});

    try {
      startAddress = await AddressDTO.get(keyword: startKeyword);
      endAddress = await AddressDTO.get(keyword: endKeyword);

      startCoordinates = await CoordinatesDTO.get(
          admCd: startAddress.jusoList[0].admCd,
          rnMgtSn: startAddress.jusoList[0].rnMgtSn,
          udrtYn: startAddress.jusoList[0].udrtYn,
          buldMnnm: startAddress.jusoList[0].buldMnnm,
          buldSlno: startAddress.jusoList[0].buldSlno);
      endCoordinates = await CoordinatesDTO.get(
          admCd: endAddress.jusoList[0].admCd,
          rnMgtSn: endAddress.jusoList[0].rnMgtSn,
          udrtYn: endAddress.jusoList[0].udrtYn,
          buldMnnm: endAddress.jusoList[0].buldMnnm,
          buldSlno: endAddress.jusoList[0].buldSlno);

      if (endCoordinates.jusoList[0].entX.isEmpty ||
          endCoordinates.jusoList[0].entY.isEmpty) {
        throw "도착 주소가 올바르지 않습니다";
      }

      startPoint = transform(
          startCoordinates.jusoList[0].entX, startCoordinates.jusoList[0].entY);
      endPoint = transform(
          endCoordinates.jusoList[0].entX, endCoordinates.jusoList[0].entY);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectPathView(
            startAddress: startAddress.jusoList[0].roadAddr,
            endAddress: endAddress.jusoList[0].roadAddr,
            startPoint: Coordinate(
                latitude: startPoint.toArray()[1],
                longitude: startPoint.toArray()[0]),
            endPoint: Coordinate(
                latitude: endPoint.toArray()[1],
                longitude: endPoint.toArray()[0]),
            startKeyword: startKeyword,
            endKeyword: endKeyword,
          ),
        ),
      );
      isWorking = false;
      setState(() {});
    } catch (err) {
      makeToast(msg: err.toString());
      isWorking = false;
      setState(() {});
    }
  }
}
