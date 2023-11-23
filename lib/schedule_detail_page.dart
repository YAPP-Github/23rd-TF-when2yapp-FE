import 'package:flutter/material.dart';

import 'api/dto/schedule_response.dart';
import 'api/when2yapp_api_client.dart';
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
        appBar: AppBar(),
        body: _fetchDataAndBuild(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('복사되었습니다.'),
                  ),
                );
              },
              tooltip: '결과 공유하기',
              child: const Icon(Icons.share),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/schedule/$scheduleId/register');
              },
              tooltip: '내 일정 수정하기',
              child: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
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
          ],
        ),
      ),
    );
  }
}
