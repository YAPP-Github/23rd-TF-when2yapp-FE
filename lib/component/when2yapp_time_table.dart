import 'package:flutter/material.dart';

import '../util/date_time_utils.dart';
import '../util/when2yapp_time.dart';

class When2YappTimeTable extends StatefulWidget {
  // 날짜
  final List<DateTime> dateTimes;
  final int columnSize = 5;
  final bool isEditable;
  final ValueNotifier<List<DateTime>> selectedDateTimesNotifier;
  List<DateTime>? selectedDateTimes;
  static const double headerHeight = 54.0;
  static const double cellWidth = 54.0;
  static const double cellHeight = 22.0;

  When2YappTimeTable({
    required this.dateTimes,
    required this.isEditable,
    required this.selectedDateTimesNotifier,
    this.selectedDateTimes,
  });

  @override
  State<StatefulWidget> createState() {
    return _When2YappTimeTableState();
  }
}

class _When2YappTimeTableState extends State<When2YappTimeTable> {
  // 선택된 시간 목록
  late List<DateTime> selectedStartDateTimes;
  late int limit;
  late int offset;

  @override
  void initState() {
    super.initState();
    selectedStartDateTimes = widget.selectedDateTimes ?? [];
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
                widget.selectedDateTimesNotifier.value = selectedStartDateTimes;
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
          _buildDayColumn(
              dateTimes[i],
              updateSelectedDateTimesCallback,
              hasDateTimeCallback,
          ),
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
    UpdateSelectedDateTimesCallback? updateSelectedDateTimesCallback,
    HasDateTimeCallback? hasDateTimeCallback,
  ) {
    return Column(
      children: [
        for (var i = startTime; i <= endTime; i = i.addMinute(30))
          _buildCell(
            dateTime.add(Duration(hours: i.hour, minutes: i.minute)),
            updateSelectedDateTimesCallback,
            hasDateTimeCallback,
          ),
      ],
    );
  }

  _When2YappTimeTableCell _buildCell(
    DateTime dateTime,
    UpdateSelectedDateTimesCallback? updateSelectedDateTimesCallback,
    HasDateTimeCallback? hasDateTimeCallback,
  ) {
    return _When2YappTimeTableCell(
      startTime: dateTime,
      isSelected: hasDateTimeCallback?.call(dateTime) ?? false,
      updateSelectedDateTimesCallback: updateSelectedDateTimesCallback,
    );
  }
}

class _When2YappTimeTableCell extends StatefulWidget {
  final DateTime startTime;
  final bool isSelected;
  final UpdateSelectedDateTimesCallback? updateSelectedDateTimesCallback;

  _When2YappTimeTableCell({
    required this.startTime,
    required this.isSelected,
    required this.updateSelectedDateTimesCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return _When2YappTimeTableCellState();
  }
}

class _When2YappTimeTableCellState extends State<_When2YappTimeTableCell> {
  bool selected = false;

  @override
  void initState() {
    selected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (event.down) {
          setState(() {
            selected = !selected;
            widget.updateSelectedDateTimesCallback?.call(widget.startTime);
          });
        }
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            selected = !selected;
            widget.updateSelectedDateTimesCallback?.call(widget.startTime);
          });
        },
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
              selected ? Container(color: const Color(0xFFFA6027)) : null),
        ),
      ),
    );
  }
}

/// dateTime 이 현재 선택된 시간 목록에 있으면 삭제, 없으면 추가합니다.
typedef UpdateSelectedDateTimesCallback = void Function(DateTime dateTime);

/// dateTime 이 현재 선택된 시간 목록에 포함되어있는지 여부를 확인합니다.
typedef HasDateTimeCallback = bool Function(DateTime dateTime);
