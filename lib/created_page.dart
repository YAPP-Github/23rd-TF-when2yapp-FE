import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:when2yapp/api/when2yapp_api_client.dart';
import 'package:when2yapp/component/dash_widget.dart';

import 'api/dto/schedule_response.dart';
import 'resources/resources.dart';

class CreatedPage extends StatelessWidget {
  CreatedPage({
    super.key,
    required this.scheduleId,
  });

  final When2YappApiClient _apiClient = When2YappApiClient();
  final int scheduleId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F8),
        appBar: AppBar(),
        body: Column(children: [
          const Center(
              child: Text(
            '약속을 만들었어요!',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          )),
          const Center(
              child: Text(
            '친구에게 공유해 보세요.',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          )),
          const SizedBox(height: 20),
          Center(child: Image.asset(Images.yappucongrats)),
          Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildScheduleInformation(),
          )),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('복사되었습니다.')),
                );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFA6027),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  )),
              child: const Text("약속 링크 복사하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white)),
            ),
          ),
          Container(
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 60),
            child: OutlinedButton(
              onPressed: () {
                const scheduleId = 1;
                Navigator.of(context).pushNamed('/schedule/$scheduleId');
              },
              style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFA6027),
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 0.8, color: Color(0xFFFA6027)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  )),
              child: const Text("일정 등록하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xFFFA6027))),
            ),
          ),
        ]),
      ),
    );
  }

  /// 약속 안내
  Widget _buildScheduleInformation() {
    return FutureBuilder<ScheduleResponse>(
        future: _apiClient.getSchedule(scheduleId: scheduleId),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError || !asyncSnapshot.hasData) {
            return Container();
          }
          final scheduleResponse = asyncSnapshot.data!;
          final startDate = scheduleResponse.startDate;
          final endDate = scheduleResponse.endDate;
          final startTime = scheduleResponse.startTime;
          final endTime = scheduleResponse.endTime;
          final formattedDateRange = _getFormattedDateRange(startDate, endDate);

          return Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text("약속 안내",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ),
              const SizedBox(height: 18),
              const DashWidget(
                color: Color(0xFFA09DA5),
                height: 0.6,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("날짜",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xFFA09DA5))),
                  const SizedBox(width: 18),
                  Text(formattedDateRange,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black))
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Text("시간",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xFFA09DA5))),
                  const SizedBox(width: 18),
                  Text(
                      '${startTime.substring(0, 5)} - ${endTime.substring(0, 5)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black))
                ],
              )
            ],
          );
        });
  }

  String _getFormattedDateRange(DateTime startDate, DateTime endDate) {
    if (startDate.month == endDate.month) {
      return '${DateFormat('M월 d일').format(startDate)} - ${DateFormat('d일').format(endDate)}';
    } else {
      return '${DateFormat('M월 d일').format(startDate)} - ${DateFormat('M월 d일').format(endDate)}';
    }
  }
}
