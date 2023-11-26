import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api/dto/schedule_response.dart';
import 'api/when2yapp_api_client.dart';
import 'util/date_time_utils.dart';
import 'resources/resources.dart';

class SchedulePageWidget extends StatefulWidget {
  final int scheduleId;
  final When2YappApiClient _apiClient = When2YappApiClient();

  SchedulePageWidget({
    super.key,
    required this.scheduleId,
  });

  @override
  SchedulePage createState() => SchedulePage();
}

class SchedulePage extends State<SchedulePageWidget> {
  final _nameTextFieldController = TextEditingController();

  bool _isValidName() {
    return (_nameTextFieldController.text.isNotEmpty &&
        _nameTextFieldController.text.length <= 15);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F8),
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
          body: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                child: const Text('지금 바로 일정 등록하고\n약속을 잡아보세요!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: const Text('약속 안내',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ),
              _buildScheduleInfo(),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                child: const Text('이름을 입력해 주세요.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _nameTextFieldController,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '최대 15자까지 입력할 수 있어요.',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xFFA09DA5)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black)),
                  onChanged: (name) {
                    setState(() {});
                  },
                ),
              ),
              const Spacer(),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 18, 30),
                    child: Image.asset(Images.yappucalendar)),
              ),
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                child: TextButton(
                  onPressed: _onRegisterButtonPressed(),
                  style: TextButton.styleFrom(
                      disabledBackgroundColor: const Color(0xFFEEECF3),
                      disabledForegroundColor: const Color(0xFFA09DA5),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFFA6027),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      )),
                  child: const Text("일정 등록하기",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildScheduleInfo() {
    return FutureBuilder<ScheduleResponse>(
      future: widget._apiClient.getSchedule(scheduleId: widget.scheduleId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final scheduleResponse = asyncSnapshot.data!;
          return _buildScheduleMetadata(
            dateRangeText: DateTimeUtils.getFormattedDateRangeText(
              startDate: scheduleResponse.startDate,
              endDate: scheduleResponse.endDate,
            ),
            timeRangeText: DateTimeUtils.getFormattedTimeRangeText(
              startTime: scheduleResponse.startTime,
              endTime: scheduleResponse.endTime,
            ),
          );
        }
        return _buildScheduleMetadata();
      },
    );
  }

  Widget _buildScheduleMetadata({
    String? dateRangeText,
    String? timeRangeText,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text("날짜",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color(0xFFA09DA5))),
              const SizedBox(width: 18),
              Text(dateRangeText ?? '',
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
              Text(timeRangeText ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black))
            ],
          )
        ],
      ),
    );
  }

  VoidCallback? _onRegisterButtonPressed() {
    if (!_isValidName()) {
      return null;
    }
    return () async {
      // FIXME: 항상 만들지 말고, 이미 스케줄에 동일한 이름이 등록되어있으면 그 이름의 식별자를 써야함.
      final selectedScheduleResponse = await widget._apiClient.createRespondent(
        scheduleId: widget.scheduleId,
        name: _nameTextFieldController.text,
      );
      if (!mounted) {
        return;
      }
      final url =
          '/schedule/${widget.scheduleId}/register/${selectedScheduleResponse.id}';
      if (kIsWeb) {
        html.window.history.pushState(null, '언제얍', url);
      }
      Navigator.of(context).pushNamed(url);
    };
  }
}
