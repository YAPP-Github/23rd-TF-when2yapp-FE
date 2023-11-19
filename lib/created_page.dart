import 'package:flutter/material.dart';
import 'package:when2yapp/component/dash_widget.dart';

class CreatedPage extends StatelessWidget {
  const CreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F8),
        appBar: AppBar(),
        body: Column(children: [
          const Center(
              child: Text(
            '약속을 만들었어요!',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          )),
          const Center(
              child: Text(
            '친구에게 공유해 보세요.',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          )),
          const SizedBox(height: 20),
          Center(child: Image.asset('assets/yappucongrats.png')),
          Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("약속 안내",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black)),
                ),
                SizedBox(height: 18),
                DashWidget(
                  color: Color(0xFFA09DA5),
                  height: 0.6,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("날짜",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Color(0xFFA09DA5))),
                    SizedBox(width: 18),
                    Text("11월 8일 - 15일",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black))
                  ],
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    Text("시간",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Color(0xFFA09DA5))),
                    SizedBox(width: 18),
                    Text("12:00 - 22:00",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black))
                  ],
                )
              ],
            ),
          )),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('복사되었습니다.')),
                );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFA6027),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  )),
              child: const Text("약속 링크 복사하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white)),
            ),
          ),
          Container(
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 60),
            child: OutlinedButton(
              onPressed: () {
                const scheduleId = 1;
                Navigator.of(context).pushNamed('/schedule/$scheduleId');
              },
              style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFA6027),
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0.8, color: Color(0xFFFA6027)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  )),
              child: const Text("일정 등록하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xFFFA6027))),
            ),
          ),
        ]),
      ),
    );
  }
}
