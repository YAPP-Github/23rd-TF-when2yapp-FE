import 'package:flutter/material.dart';
import 'package:when2yapp/component/when2yapp_time_table.dart';

class ScheduleRegisterPage extends StatelessWidget {
  final int scheduleId = 1;
  final DateTime startDate = DateTime.now();
  final DateTime endDate = DateTime.now().add(const Duration(days: 6));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${startDate.month}월${startDate.day}일부터 ${endDate.day}일까지\n가능하신 일정을 선택해주세요'),
                When2YappTimeTable(
                  dateTimes: [
                    for (var i = 0;
                        i <= endDate.difference(startDate).inDays;
                        i++)
                      startDate.add(Duration(days: i)),
                  ],
                  isEditable: true,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/schedule/$scheduleId/detail');
          },
          tooltip: '일정 등록하기',
          child: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
