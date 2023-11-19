import 'package:flutter/material.dart';

class CreatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('약속을 만들었어요!\n친구에게 공유해 보세요.'),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('복사되었습니다.')),
                );
              },
              tooltip: '약속 링크 복사하기',
              child: const Icon(Icons.share),
            ),
            FloatingActionButton(
              onPressed: () {
                const scheduleId = 1;
                Navigator.of(context).pushNamed('/schedule/$scheduleId');
              },
              tooltip: '일정 등록하기',
              child: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
