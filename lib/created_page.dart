import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'api/dto/schedule_response.dart';
import 'api/when2yapp_api_client.dart';
import 'component/dash_widget.dart';
import 'component/when2yapp_elevated_button.dart';
import 'component/when2yapp_outlined_button.dart';
import 'resources/resources.dart';
import 'util/date_time_utils.dart';

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
        body: Column(
          children: [
            const Center(
                child: Text(
              '약속을 만들었어요!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
            )),
            const Center(
                child: Text(
              '친구에게 공유해 보세요.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
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
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            When2YappElevatedButton(
              onPressed: () => _onShareButtonPressed(context),
              labelText: '약속 링크 복사하기',
            ),
            const SizedBox(height: 14),
            When2YappOutlinedButton(
              onPressed: () => _onRegisterButtonPressed(context),
              labelText: '일정 등록하기',
            ),
          ],
        ),
      ),
    );
  }

  /// 약속 링크 복사하기
  void _onShareButtonPressed(BuildContext context) {
    if (kIsWeb) {
      Clipboard.setData(ClipboardData(text: window.location.href));
    }
    showToast(
      '복사되었습니다.',
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      position: const StyledToastPosition(align: Alignment.bottomCenter, offset: 215.0),
      borderRadius: BorderRadius.circular(10.0),
      textStyle: const TextStyle(fontSize: 16.0, color: Color(0xFFFA6027)),
      backgroundColor: const Color(0xFFFEDFD4)
    );
  }

  /// 일정 등록하기
  void _onRegisterButtonPressed(BuildContext context) {
    final url = '/schedule/$scheduleId';
    if (kIsWeb) {
      window.history.pushState(null, '언제얍', url);
    }
    Navigator.of(context).pushNamed(url);
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
        final formattedTimeRange = DateTimeUtils.getFormattedTimeRangeText(
          startTime: startTime,
          endTime: endTime,
        );

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
                Text(formattedTimeRange,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black))
              ],
            )
          ],
        );
      },
    );
  }

  String _getFormattedDateRange(DateTime startDate, DateTime endDate) {
    return DateTimeUtils.getFormattedDateRangeText(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
