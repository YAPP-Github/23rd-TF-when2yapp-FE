import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api/dto/schedule_response.dart';
import 'api/when2yapp_api_client.dart';
import 'component/when2yapp_elevated_button.dart';
import 'component/when2yapp_outlined_button.dart';
import 'component/when2yapp_time_table.dart';

class ScheduleDetailPage extends StatelessWidget {
  final int scheduleId;
  final int selectedScheduleId;

  ScheduleDetailPage({
    required this.scheduleId,
    required this.selectedScheduleId,
  });

  final When2YappApiClient _apiClient = When2YappApiClient();
  final int numberOfPeople = 7;
  final ValueNotifier<List<DateTime>> selectedDateTimesNotifier =
      ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              if (kIsWeb) {
                window.history.back();
              }
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _fetchDataAndBuild(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            When2YappElevatedButton(
              onPressed: () => _onShareButtonPressed(context),
              labelText: '결과 공유하기',
            ),
            const SizedBox(height: 14),
            When2YappOutlinedButton(
              onPressed: () => _onEditButtonPressed(context),
              labelText: '내 일정 수정하기',
            ),
          ],
        ),
      ),
    );
  }

  void _onShareButtonPressed(BuildContext context) {
    if (kIsWeb) {
      Clipboard.setData(ClipboardData(text: window.location.href));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('복사되었습니다.'),
      ),
    );
  }

  void _onEditButtonPressed(BuildContext context) {
    final url = '/schedule/$scheduleId/register/$selectedScheduleId';
    if (kIsWeb) {
      window.history.pushState(null, '언제얍', url);
    }
    Navigator.of(context).pushNamed(url);
  }

  Widget _fetchDataAndBuild() {
    return FutureBuilder<ScheduleResponse>(
        future: _apiClient.getSchedule(
          scheduleId: scheduleId,
        ),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (asyncSnapshot.hasError) {
            return Center(
              child: Text(asyncSnapshot.error.toString()),
            );
          }
          final scheduleResponse = asyncSnapshot.data!;
          final List<DateTime> dateTimes = [
            for (var dateTime = scheduleResponse.startDate;
                !dateTime.isAfter(scheduleResponse.endDate);
                dateTime = dateTime.add(const Duration(days: 1)))
              dateTime,
          ];
          return _buildBody(
              dateTimes: dateTimes,
              selectedDateTimes: selectedDateTimesNotifier.value =
                  scheduleResponse.selectedSchedules
                      .expand((e) =>
                          e.availabilities.map((f) => f.startTime).toList())
                      .toList());
        });
  }

  Widget _buildBody({
    required List<DateTime> dateTimes,
    required List<DateTime> selectedDateTimes,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$numberOfPeople명의 만날 수 있는 시간이에요.'),
            When2YappTimeTable(
              dateTimes: dateTimes,
              isEditable: false,
              selectedDateTimesNotifier: selectedDateTimesNotifier,
              selectedDateTimes: selectedDateTimes,
            ),
            const SizedBox(height: 160,),
          ],
        ),
      ),
    );
  }
}
