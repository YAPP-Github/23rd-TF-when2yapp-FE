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
    final scheduleCreatedPagePattern = RegExp(r'^/schedule/(\d+)/created$');
    final schedulePagePattern = RegExp(r'^/schedule/(\d+)$');
    final scheduleRegisterPagePattern = RegExp(r'^/schedule/(\d+)/register/(\d+)$');
    final scheduleDetailPagePattern = RegExp(r'^/schedule/(\d+)/detail/(\d+)$');

    return MaterialApp(
      title: '언제얍',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFEDFD4)),
        scaffoldBackgroundColor: const Color(0xFFF5F8F8),
        appBarTheme: const AppBarTheme(
          color: Color(0xFFF5F8F8),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? const Color(0xFFFA6027)
                  : const Color(0xFFDBDBDB)),
          checkColor: MaterialStateProperty.all(Colors.white),
          side: BorderSide.none,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.disabled)
                    ? const Color(0xFFEEECF3)
                    : const Color(0xFFFA6027)
            ),
            foregroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.disabled)
                  ? const Color(0xFFA09DA5)
                  : Colors.white,
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
              vertical: 15,
            )),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.disabled)
                    ? const Color(0xFFEEECF3)
                    : Colors.white
            ),
            foregroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.disabled)
                    ? const Color(0xFFA09DA5)
                    : const Color(0xFFFA6027)
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            )),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
              vertical: 16,
            )),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: const BorderSide(width: 0.8, color: Color(0xFFFA6027)),
            )),
            side: MaterialStateProperty.all(const BorderSide(
              color: Color(0xFFFA6027),
            )),
          ),
        ),
        fontFamily: 'Pretendard',
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
          return MaterialPageRoute(
            builder: (context) => CreatePage(),
          );
        }
        if (scheduleCreatedPagePattern.hasMatch(settings.name!)) {
          final scheduleId = int.parse(scheduleCreatedPagePattern
              .allMatches(settings.name!)
              .first
              .group(1)!);
          return MaterialPageRoute(
            builder: (context) => CreatedPage(
              scheduleId: scheduleId,
            ),
          );
        }
        if (schedulePagePattern.hasMatch(settings.name!)) {
          final scheduleId = int.parse(schedulePagePattern
              .allMatches(settings.name!)
              .first
              .group(1)!);
          return MaterialPageRoute(
            builder: (context) => SchedulePageWidget(
              scheduleId: scheduleId,
            ),
          );
        }
        if (scheduleRegisterPagePattern.hasMatch(settings.name!)) {
          final matches = scheduleRegisterPagePattern
              .allMatches(settings.name!)
              .first;
          return MaterialPageRoute(
            builder: (context) => ScheduleRegisterPage(
              scheduleId: int.parse(matches.group(1)!),
              selectedScheduleId: int.parse(matches.group(2)!),
            ),
          );
        }
        if (scheduleDetailPagePattern.hasMatch(settings.name!)) {
          final matches = scheduleDetailPagePattern
              .allMatches(settings.name!)
              .first;
          return MaterialPageRoute(
            builder: (context) => ScheduleDetailPage(
              scheduleId: int.parse(matches.group(1)!),
              selectedScheduleId: int.parse(matches.group(2)!),
            ),
          );
        }
        throw Exception(
            '\'settings.name\' is not valid. name: ${settings.name}');
      },
    );
  }
}
