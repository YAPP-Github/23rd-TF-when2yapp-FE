import 'package:flutter/material.dart';
import 'package:when2yapp/util/when2yapp_time.dart';

import '../util/date_time_utils.dart';

class When2YappTimeTable extends StatefulWidget {
  final List<DateTime> dateTimes;
  final int columnSize = 5;
  final bool isEditable;
  static const double headerHeight = 54.0;
  static const double cellWidth = 54.0;
  static const double cellHeight = 22.0;

  When2YappTimeTable({
    required this.dateTimes,
    required this.isEditable,
  });

  @override
  State<StatefulWidget> createState() {
    return _When2YappTimeTableState();
  }
}

class _When2YappTimeTableState extends State<When2YappTimeTable> {
  late List<DateTime> selectedStartDateTimes;
  late int limit;
  late int offset;

  @override
  void initState() {
    super.initState();
    selectedStartDateTimes = [];
    limit = widget.columnSize;
    offset = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateSelector(
          dateTimes: widget.dateTimes,
          limit: limit,
          offset: offset,
          onPreviousPressed: () {
            setState(() {
              offset -= 1;
            });
          },
          onNextPressed: () {
            setState(() {
              offset += 1;
            });
          },
        ),
        _TimeSelector(
          dateTimes: widget.dateTimes,
          limit: limit,
          offset: offset,
          updateSelectedDateTimesCallback: (dateTime) {
            if (widget.isEditable) {
              setState(() {
                if (selectedStartDateTimes.contains(dateTime)) {
                  selectedStartDateTimes.remove(dateTime);
                } else {
                  selectedStartDateTimes.add(dateTime);
                }
              });
            }
          },
          hasDateTimeCallback: (dateTime) {
            return selectedStartDateTimes.contains(dateTime);
          },
        ),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  final List<DateTime> dateTimes;
  final int limit;
  final int offset;
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;

  _DateSelector({
    required this.dateTimes,
    required this.limit,
    required this.offset,
    this.onPreviousPressed,
    this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: When2YappTimeTable.headerHeight,
          width: When2YappTimeTable.cellWidth,
          child: IconButton(
            onPressed: offset - 1 >= 0 ? () => onPreviousPressed?.call() : null,
            icon: const Icon(Icons.chevron_left),
          ),
        ),
        for (var i = offset; i < offset + limit; i++) _buildTitle(dateTimes[i]),
        SizedBox(
          height: When2YappTimeTable.headerHeight,
          width: When2YappTimeTable.cellWidth,
          child: IconButton(
            onPressed: (offset + 1 + limit) <= dateTimes.length
                ? () => onNextPressed?.call()
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(DateTime dateTime) {
    return SizedBox(
      height: When2YappTimeTable.headerHeight,
      width: When2YappTimeTable.cellWidth,
      child: Column(
        children: [
          Text('${dateTime.month}.${dateTime.day}'),
          Text(DateTimeUtils.getFormattedWeekDay(dateTime)),
        ],
      ),
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final List<DateTime> dateTimes;
  final int limit;
  final int offset;
  final When2YappTime startTime = When2YappTime(7, 0);
  final When2YappTime endTime = When2YappTime(26, 0);
  final UpdateSelectedDateTimesCallback? updateSelectedDateTimesCallback;
  final HasDateTimeCallback? hasDateTimeCallback;

  _TimeSelector({
    required this.dateTimes,
    required this.limit,
    required this.offset,
    this.updateSelectedDateTimesCallback,
    this.hasDateTimeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildColumnTitle(),
        for (var i = offset; i < offset + limit; i++)
          _buildDayColumn(dateTimes[i]),
      ],
    );
  }

  Widget _buildColumnTitle() {
    return Column(
      children: [
        for (var i = startTime; i <= endTime; i = i.addMinute(60))
          SizedBox(
            height: When2YappTimeTable.cellHeight * 2,
            width: When2YappTimeTable.cellWidth,
            child: Center(child: Text('${i.hour}')),
          ),
      ],
    );
  }

  Widget _buildDayColumn(
    DateTime dateTime,
  ) {
    return Column(
      children: [
        for (var i = startTime; i <= endTime; i = i.addMinute(30))
          _buildCell(
            dateTime,
            i,
            updateSelectedDateTimesCallback,
            hasDateTimeCallback,
          ),
      ],
    );
  }

  Widget _buildCell(
    DateTime dateTime,
    When2YappTime startTime,
    UpdateSelectedDateTimesCallback? updateSelectedDateTimesCallback,
    HasDateTimeCallback? hasDateTimeCallback,
  ) {
    return _When2YappTimeTableCell(
      startTime: startTime,
      isSelected: hasDateTimeCallback?.call(dateTime.copyWith(
            hour: startTime.hour,
            minute: startTime.minute,
          )) ??
          false,
      onTapDown: (_) {
        print('dateTime: $dateTime, startTime: $startTime');
        updateSelectedDateTimesCallback?.call(dateTime.copyWith(
          hour: startTime.hour,
          minute: startTime.minute,
        ));
      },
    );
  }
}

class _When2YappTimeTableCell extends StatelessWidget {
  final When2YappTime startTime;
  final bool isSelected;
  final GestureTapDownCallback? onTapDown;

  _When2YappTimeTableCell({
    required this.startTime,
    required this.isSelected,
    this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: SizedBox(
        height: When2YappTimeTable.cellHeight,
        width: When2YappTimeTable.cellWidth,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child:
                isSelected ? Container(color: const Color(0xFFFA6027)) : null),
      ),
    );
  }
}

/// dateTime 이 현재 선택된 시간 목록에 있으면 삭제, 없으면 추가합니다.
typedef UpdateSelectedDateTimesCallback = void Function(DateTime dateTime);

/// dateTime 이 현재 선택된 시간 목록에 포함되어있는지 여부를 확인합니다.
typedef HasDateTimeCallback = bool Function(DateTime dateTime);
