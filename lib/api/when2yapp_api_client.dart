import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dto/availability_response.dart';
import 'dto/schedule_response.dart';
import 'dto/selected_schedule_response.dart';

class When2YappApiClient {
  final String host = 'api.when2yapp.com';

  /// 약속 생성
  Future<ScheduleResponse> createSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required String startTime,
    required String endTime,
  }) async =>
      http
          .post(
            Uri.https(
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
  Future<ScheduleResponse> getSchedule({
    required int scheduleId,
  }) async =>
      http
          .get(
            Uri.https(
              host,
              '/schedule/$scheduleId',
            ),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
            },
          )
          .then((value) => jsonDecode(utf8.decode(value.bodyBytes)))
          .then((value) => ScheduleResponse.fromJson(value));

  /// 응답 주체 생성
  Future<SelectedScheduleResponse> createRespondent({
    required int scheduleId,
    required String name,
  }) async {
    return http
        .post(
          Uri.https(
            host,
            '/schedule/$scheduleId/selected/',
          ),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'username': name,
          }),
        )
        .then((value) {
          if (kDebugMode) {
            print(value.body);
          }
          return value;
        })
        .then((value) => jsonDecode(utf8.decode(value.bodyBytes)))
        .then((value) => SelectedScheduleResponse.fromJson(value));
  }

  /// 가능한 시각 목록 추가
  Future<List<AvailabilityResponse>> registerAvailabilities({
    required int scheduleId,
    required int selectedScheduleId,
    required List<DateTime> selectedDateTimes,
  }) async {
    var requestBody = selectedDateTimes
                .map((e) => {
                      'startTime': e.toIso8601String(),
                      'endTime':
                          e.add(const Duration(minutes: 30)).toIso8601String(),
                    })
                .toList();
    if (kDebugMode) {
      print(requestBody);
    }
    return http
        .post(
          Uri.https(
            host,
            '/schedule/$scheduleId/selected/$selectedScheduleId/',
          ),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            requestBody,
          ),
        )
        .then((value) => jsonDecode(utf8.decode(value.bodyBytes)))
        .then((value) => (value as List<dynamic>)
            .map((e) => AvailabilityResponse.fromJson(e))
            .toList());
  }
}
