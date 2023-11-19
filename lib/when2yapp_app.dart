import 'package:flutter/material.dart';

import 'create_page.dart';
import 'created_page.dart';
import 'schedule_detail_page.dart';
import 'schedule_page.dart';
import 'schedule_register_page.dart';
import 'splash_page.dart';

class When2YappApp extends StatelessWidget {
  const When2YappApp({super.key});

  @override
  Widget build(BuildContext context) {
    final schedulePagePattern = RegExp(r'^/schedule/(\d+)$');
    final scheduleRegisterPagePattern = RegExp(r'^/schedule/(\d+)/register$');
    final scheduleDetailPagePattern = RegExp(r'^/schedule/(\d+)/detail$');

    return MaterialApp(
      title: '언제얍',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFEDFD4)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == null || settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => SplashPage(),
          );
        }
        if (settings.name! == '/create') {
          final queryParameters = Uri.parse(settings.name!).queryParameters;
          return MaterialPageRoute(
            builder: (context) => CreatePage(),
          );
        }
        if (settings.name! == '/created') {
          final queryParameters = Uri.parse(settings.name!).queryParameters;
          return MaterialPageRoute(
            builder: (context) => CreatedPage(),
          );
        }
        if (schedulePagePattern.hasMatch(settings.name!)) {
          return MaterialPageRoute(
            builder: (context) => SchedulePage(),
          );
        }
        if (scheduleRegisterPagePattern.hasMatch(settings.name!)) {
          return MaterialPageRoute(
            builder: (context) => ScheduleRegisterPage(),
          );
        }
        if (scheduleDetailPagePattern.hasMatch(settings.name!)) {
          return MaterialPageRoute(
            builder: (context) => ScheduleDetailPage(),
          );
        }
        throw Exception('\'settings.name\' is not valid. name: ${settings.name}');
      },
    );
  }
}
