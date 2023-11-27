import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api/dto/schedule_response.dart';
import 'api/when2yapp_api_client.dart';
import 'component/when2yapp_elevated_button.dart';
import 'component/when2yapp_time_table.dart';

class ScheduleRegisterPage extends StatefulWidget {
  final int scheduleId;
  final int selectedScheduleId;
  final When2YappApiClient _apiClient = When2YappApiClient();

  ScheduleRegisterPage({
    required this.scheduleId,
    required this.selectedScheduleId,
  });

  @override
  State<StatefulWidget> createState() {
    return _ScheduleRegisterPageState();
  }
}

class _ScheduleRegisterPageState extends State<ScheduleRegisterPage> {
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
                html.window.history.back();
              }
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _fetchDataAndBuild(),
        floatingActionButton: When2YappElevatedButton(
          onPressed: _onButtonPressed,
          labelText: '일정 등록하기',
        ),
      ),
    );
  }

  void _onButtonPressed() async {
    if (kDebugMode) {
      print(selectedDateTimesNotifier.value);
    }
    final availabilities =
    await widget._apiClient.registerAvailabilities(
      scheduleId: widget.scheduleId,
      selectedScheduleId: widget.selectedScheduleId,
      selectedDateTimes: selectedDateTimesNotifier.value,
    );
    if (kDebugMode) {
      print(availabilities);
    }
    if (!mounted) {
      return;
    }
    final url =
        '/schedule/${widget.scheduleId}/detail/${widget.selectedScheduleId}';
    if (kIsWeb) {
      html.window.history.pushState(null, '언제얍', url);
    }
    Navigator.of(context).pushNamed(url);
  }

  Widget _fetchDataAndBuild() {
    return FutureBuilder<ScheduleResponse>(
        future: widget._apiClient.getSchedule(scheduleId: widget.scheduleId),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return const Center(child: Text('일정을 불러오는데 실패했습니다.'));
          }
          final scheduleResponse = asyncSnapshot.data!;
          final startDate = scheduleResponse.startDate;
          final endDate = scheduleResponse.endDate;
          return _buildBody(startDate, endDate);
        });
  }

  Widget _buildBody(
    DateTime startDate,
    DateTime endDate,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${startDate.month}월${startDate.day}일부터 ${endDate.day}일까지\n가능하신 일정을 선택해주세요'),
            When2YappTimeTable(
              dateTimes: [
                for (var i = 0; i <= endDate.difference(startDate).inDays; i++)
                  startDate.add(Duration(days: i)),
              ],
              isEditable: true,
              selectedDateTimesNotifier: selectedDateTimesNotifier,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
