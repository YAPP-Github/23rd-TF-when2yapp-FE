import 'package:flutter/material.dart';

import '../util/DateTimeUtils.dart';

class When2YappTimeTable extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final int columnSize = 5;
  static const double cellWidth = 54.0;
  static const double cellHeight = 44.0;

  When2YappTimeTable({
    required this.startDate,
    required this.endDate,
  });

  @override
  State<StatefulWidget> createState() {
    return _When2YappTimeTableState();
  }
}

class _When2YappTimeTableState extends State<When2YappTimeTable> {
  late DateTime firstDate;
  late DateTime lastDate;

  @override
  void initState() {
    super.initState();
    firstDate = widget.startDate;
    lastDate = widget.startDate.add(Duration(days: widget.columnSize - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateSelector(
          firstDate: firstDate,
          lastDate: lastDate,
        ),
        _TimeSelector(
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;

  _DateSelector({
    required this.firstDate,
    required this.lastDate,
    this.onPreviousPressed,
    this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: When2YappTimeTable.cellHeight,
          width: When2YappTimeTable.cellWidth,
          child: IconButton(
            onPressed: onPreviousPressed,
            icon: const Icon(Icons.chevron_left),
          ),
        ),
        for (var i = 0; i <= lastDate.difference(firstDate).inDays; i++)
          _buildTitle(firstDate.add(Duration(days: i))),
        SizedBox(
          height: When2YappTimeTable.cellHeight,
          width: When2YappTimeTable.cellWidth,
          child: IconButton(
            onPressed: onNextPressed,
            icon: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(DateTime dateTime) {
    return SizedBox(
      height: When2YappTimeTable.cellHeight,
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
  final DateTime firstDate;
  final DateTime lastDate;
  final int startTime = 7;
  final int endTime = 26;

  const _TimeSelector({
    required this.firstDate,
    required this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildColumnTitle(),
        for (var i = 0; i <= lastDate.difference(firstDate).inDays; i++)
          _buildDayColumn(firstDate.add(Duration(days: i))),
      ],
    );
  }

  Widget _buildColumnTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = startTime; i <= endTime; i++)
          SizedBox(
            height: When2YappTimeTable.cellHeight,
            width: When2YappTimeTable.cellWidth,
            child: Text('${i % 24}'),
          ),
      ],
    );
  }

  Widget _buildDayColumn(
    DateTime dateTime,
  ) {
    return Column(
      children: [
        for (var i = startTime; i <= endTime; i++)
          _buildCell(
            dateTime,
            i,
            i + 1,
          ),
      ],
    );
  }

  Widget _buildCell(
    DateTime dateTime,
    int startTime,
    int endTime,
  ) {
    return SizedBox(
      height: When2YappTimeTable.cellHeight,
      width: When2YappTimeTable.cellWidth,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Text('$startTime ~ $endTime'),
      ),
    );
  }
}
