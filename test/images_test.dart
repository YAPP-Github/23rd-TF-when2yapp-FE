import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:when2yapp/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.splashbackground).existsSync(), isTrue);
    expect(File(Images.splashchip).existsSync(), isTrue);
    expect(File(Images.yappucalendar).existsSync(), isTrue);
    expect(File(Images.yappucongrats).existsSync(), isTrue);
  });
}
