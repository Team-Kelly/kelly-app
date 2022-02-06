import 'package:cotten_candy_ui/cotten_candy_ui.dart';
import 'package:flutter/material.dart';
import 'package:app/address.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Address? address;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getAddress(String keyword) async {
    address = await callInfo(keyword);
    setState(() {
      address = address;
    });
    print('${address!.jusoList[0].roadAddr}');
    print('${address!.jusoList[1].roadAddr}');
    print('${address!.jusoList[2].roadAddr}');
    print('${address!.jusoList[3].roadAddr}');
    print('${address!.jusoList[4].roadAddr}');
    print('${address!.jusoList[5].roadAddr}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8D8),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              CandyTextField(
                onChanged: (value) {
                  getAddress(value!);
                },
                labelText: '출발',
              ),
            //   (address != null)?
            //   SingleChildScrollView(child: Expanded(
            //   child: ListView.builder(
            //     itemCount: address!.jusoList.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         tileColor: Colors.white,
            //         title: Text(address!.jusoList[index].roadAddr),
            //         onTap: () {
            //         },
            //       );
            //     },
            //   ),
            // ),):
              const SizedBox(height: 20),
              CandyTextField(
                onChanged: (value) {
                  getAddress(value!);
                },
                labelText: '도착',
              ),
              const SizedBox(height: 200),
              CandyButton(
                onPressed: () {},
                child: const Text(
                  '나의 시작길 입력하기',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: CandyColors.candyPink,
                  ),
                ),
                buttonColor: const Color(0xFFFFFFFF),
              )
            ],
          ),
        ),
      ),
    );
  }
}
