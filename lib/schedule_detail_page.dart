import 'package:flutter/material.dart';

class ScheduleDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('7명의 만날 수 있는 시간이에요.'),
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
