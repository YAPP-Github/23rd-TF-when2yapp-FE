import 'dart:html' as html;
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'api/when2yapp_api_client.dart';
import 'component/when2yapp_checkbox.dart';
import 'component/when2yapp_elevated_button.dart';

class CreatePage extends StatefulWidget {
  final When2YappApiClient _apiClient = When2YappApiClient();
  final List<TimeOption> timeOptions = [
    TimeOption(
      timeSlotName: '아침',
      range: DateTimeRange(
        start: DateTime.now().copyWith(hour: 7, minute: 0, second: 0),
        end: DateTime.now().copyWith(hour: 11, minute: 0, second: 0),
      ),
      isSelected: false,
    ),
    TimeOption(
      timeSlotName: '낮',
      range: DateTimeRange(
        start: DateTime.now().copyWith(hour: 12, minute: 0, second: 0),
        end: DateTime.now().copyWith(hour: 17, minute: 0, second: 0),
      ),
      isSelected: false,
    ),
    TimeOption(
      timeSlotName: '저녁',
      range: DateTimeRange(
        start: DateTime.now().copyWith(hour: 18, minute: 0, second: 0),
        end: DateTime.now().copyWith(hour: 22, minute: 0, second: 0),
      ),
      isSelected: false,
    ),
    TimeOption(
      timeSlotName: '밤',
      range: DateTimeRange(
        start: DateTime.now().copyWith(hour: 23, minute: 0, second: 0),
        end: DateTime.now()
            .copyWith(hour: 02, minute: 0, second: 0)
            .add(const Duration(days: 1)),
      ),
      isSelected: false,
    ),
    TimeOption(
      timeSlotName: '',
      range: null,
      isSelected: false,
    ),
  ];

  @override
  State<StatefulWidget> createState() {
    return CreatePageState();
  }
}

class CreatePageState extends State<CreatePage> {
  final DateTime _today = DateTime.now()
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [];

  @override
  void initState() {
    _rangeDatePickerValueWithDefaultValue = [
      _today,
      _today.add(const Duration(days: 6)),
    ];
    super.initState();
  }

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '날짜와 시간을 정해주세요',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                _buildDefaultRangeDatePickerWithValue(),
                _buildTimeSelectors(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        floatingActionButton: When2YappElevatedButton(
          onPressed: _onButtonPressed,
          labelText: '약속 만들기',
        ),
      ),
    );
  }

  /// 약속 만들기
  void _onButtonPressed() async {
    final scheduleResponse = await widget._apiClient.createSchedule(
      startDate: _rangeDatePickerValueWithDefaultValue[0]!,
      endDate: _rangeDatePickerValueWithDefaultValue[1]!,
      startTime: '10:00:00',
      endTime: '22:00:00',
    );
    if (!mounted) {
      return;
    }
    if (kDebugMode) {
      print('schedule: $scheduleResponse');
    }
    final url = '/schedule/${scheduleResponse.id}/created';
    if (kIsWeb) {
      html.window.history.pushState(null, '언제얍', url);
    }
    Navigator.of(context).pushNamed(url);
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      weekdayLabelTextStyle: const TextStyle(
        color: Color(0xFF101010),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      dayTextStyle: const TextStyle(
        color: Color(0xFFA09DA5),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      selectedDayHighlightColor: const Color(0xFFFA6027),
      selectedRangeDayTextStyle: const TextStyle(
        color: Color(0xFFFA6027),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      selectedRangeHighlightColor: const Color(0xFFFEDFD4),
      todayTextStyle: const TextStyle(
        color: Color(0xFFFA6027),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      weekdayLabels: [
        '일',
        '월',
        '화',
        '수',
        '목',
        '금',
        '토',
      ],
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
      ],
    );
  }

  Widget _buildTimeSelectors() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 14,
      children: widget.timeOptions
          .map((e) => _buildTimeSelector(timeOption: e))
          .toList(),
    );
  }

  Widget _buildTimeSelector({required TimeOption timeOption}) {
    return When2YappCheckBox(
      textLabel: timeOption.getFormattedText(),
    );
  }
}

class TimeOption {
  String timeSlotName;
  DateTimeRange? range;
  bool isSelected;

  TimeOption({
    required this.timeSlotName,
    required this.range,
    required this.isSelected,
  });

  toggleSelected() {
    isSelected = !isSelected;
  }

  String getFormattedText() {
    if (range == null) {
      return '직접 입력할래요.';
    }
    final dateFormat = DateFormat('HH:mm');
    return '$timeSlotName ${dateFormat.format(range!.start)} - ${dateFormat.format(range!.end)}';
  }
}
