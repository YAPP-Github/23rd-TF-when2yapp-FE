import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text('지금 바로 일정 등록하고\n약속을 잡아보세요!'),
              Text('약속 안내'),
              Text('이름을 입력해주세요'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            const scheduleId = 1;
            Navigator.of(context).pushNamed('/schedule/$scheduleId/register');
          },
          tooltip: '일정 등록하기',
          child: const Icon(Icons.chevron_right),
        )
      ),
    );
  }

}
