import 'package:flutter/material.dart';

import 'component/when2yapp_time_table.dart';

class ScheduleDetailPage extends StatelessWidget {
  final int numberOfPeople = 7;
  final DateTime scheduleStartDate = DateTime.now();
  final DateTime scheduleEndDate = DateTime.now().add(const Duration(days: 4));
  final int scheduleStartTime = 7;
  final int scheduleEndTime = 26;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$numberOfPeople명의 만날 수 있는 시간이에요.'),
              When2YappTimeTable(
                startDate: scheduleStartDate,
                endDate: scheduleEndDate,
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('복사되었습니다.'),
                  ),
                );
              },
              tooltip: '결과 공유하기',
              child: const Icon(Icons.share),
            ),
            FloatingActionButton(
              onPressed: () {
                const scheduleId = 1;
                Navigator.of(context).pushNamed('/schedule/$scheduleId/register');
              },
              tooltip: '내 일정 수정하기',
              child: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
