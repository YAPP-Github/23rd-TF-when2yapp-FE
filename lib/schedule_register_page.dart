import 'package:flutter/material.dart';

class ScheduleRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('가능하신 일정을 선택해주세요'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            const scheduleId = 1;
            Navigator.of(context).pushNamed('/schedule/$scheduleId/detail');
          },
          tooltip: '일정 등록하기',
          child: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
