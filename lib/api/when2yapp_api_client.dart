import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dto/schedule_response.dart';

class When2YappApiClient {
  final String host = '43.201.181.142:8000';

  /// 약속 생성
  Future<ScheduleResponse> createSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required String startTime,
    required String endTime,
  }) async =>
      http
          .post(
            Uri.http(
              host,
              '/schedule/',
            ),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {
                'name': 'name',
                'start_date': startDate.toIso8601String(),
                'end_date': endDate.toIso8601String(),
                'start_time': startTime,
                'end_time': endTime,
              },
            ),
          )
          .then((value) => jsonDecode(utf8.decode(value.bodyBytes)))
          .then((value) => ScheduleResponse.fromJson(value));

  /// 약속 조회
  Future<void> getSchedule(int scheduleId) async {}

  /// 응답 주체 생성
  Future<void> createRespondent() async {}

  /// 가능한 시각 목록 추가
  Future<void> registerAvailabilities() async {}
}
