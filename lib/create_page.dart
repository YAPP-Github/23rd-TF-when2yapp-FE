import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'component/when2yapp_checkbox.dart';

class CreatePage extends StatefulWidget {

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
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 6))
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('날짜와 시간을 정해주세요'),
              _buildDefaultRangeDatePickerWithValue(),
              _buildTimeSelectors()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/created');
          },
          tooltip: '약속 만들기',
          child: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Color(0xFFA09DA5),
        fontWeight: FontWeight.bold,
      ),
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      selectedDayHighlightColor: const Color(0xFFFA6027),
      selectedRangeDayTextStyle: const TextStyle(
        color: Color(0xFFFA6027),
        fontWeight: FontWeight.bold,
      ),
      selectedRangeHighlightColor: const Color(0xFFFEDFD4),
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
      children: widget.timeOptions.map((e) => _buildTimeSelector(timeOption: e)).toList(),
    );
  }

  Widget _buildTimeSelector({
    required TimeOption timeOption
  }) {
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
