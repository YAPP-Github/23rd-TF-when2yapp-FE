import 'package:flutter/material.dart';

class SchedulePageWidget extends StatefulWidget {
  @override
  SchedulePage createState() => SchedulePage();
}

class SchedulePage extends State<SchedulePageWidget> {
  final _nameTextFieldController = TextEditingController();

  bool _isValidName() {
    return (_nameTextFieldController.text.isNotEmpty &&
        _nameTextFieldController.text.length <= 15);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F8),
          appBar: AppBar(),
          body: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                child: const Text('지금 바로 일정 등록하고\n약속을 잡아보세요!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: const Text('약속 안내',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  children: [
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
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                child: const Text('이름을 입력해 주세요.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _nameTextFieldController,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '최대 15자까지 입력할 수 있어요.',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xFFA09DA5)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black)),
                  onChanged: (name) {
                    setState(() {});
                  },
                ),
              ),
              const Spacer(),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 18, 30),
                    child: Image.asset('assets/yappucalendar.png')),
              ),
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                child: TextButton(
                  onPressed: _isValidName()
                      ? () {
                          const scheduleId = 1;
                          Navigator.of(context)
                              .pushNamed('/schedule/$scheduleId/register');
                        }
                      : null,
                  style: TextButton.styleFrom(
                      disabledBackgroundColor: const Color(0xFFEEECF3),
                      disabledForegroundColor: const Color(0xFFA09DA5),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFFA6027),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      )),
                  child: const Text("일정 등록하기",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
              ),
            ],
          )),
    );
  }
}
