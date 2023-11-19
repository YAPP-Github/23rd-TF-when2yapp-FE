import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('우리 도대체\n만나는 날짜가\n언제 YAPP'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create');
        },
        tooltip: '약속 만들기',
        child: const Icon(Icons.add),
      ),
    );
  }
}
