import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('날짜와 시간을 정해주세요'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/created');
          },
          tooltip: '약속 만들기',
          child: const Icon(Icons.chevron_right),
        )
      ),
    );
  }
}
