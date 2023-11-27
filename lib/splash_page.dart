import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'component/when2yapp_elevated_button.dart';
import 'resources/resources.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 130),
              width: double.infinity,
              child: Image.asset(Images.splashbackground)),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(30, 70, 0, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  '우리 도대체\n만나는 날짜가',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 38,
                      color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 2, 0, 0),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '언제',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 38,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                      child: Image.asset(Images.splashchip))
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: When2YappElevatedButton(
        onPressed: () => _onButtonPressed(context),
        labelText: '약속 만들기',
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    if (kIsWeb) {
      html.window.history.pushState(null, '언제얍', '/create');
    }
    Navigator.of(context).pushNamed('/create');
  }
}
