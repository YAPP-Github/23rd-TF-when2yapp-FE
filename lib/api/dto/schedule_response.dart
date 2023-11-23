import 'selected_schedule_response.dart';

class ScheduleResponse {
  final int id;
  final DateTime startDate;
  final DateTime endDate;

  /// 'HH:mm:ss'
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SelectedScheduleResponse> selectedSchedules;

  ScheduleResponse(this.id, this.startDate, this.endDate, this.startTime,
      this.endTime, this.createdAt, this.updatedAt, this.selectedSchedules);

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      json['id'],
      DateTime.parse(json['startDate']).toLocal(),
      DateTime.parse(json['endDate']).toLocal(),
      json['startTime'],
      json['endTime'],
      DateTime.parse(json['createdAt']).toLocal(),
      DateTime.parse(json['updatedAt']).toLocal(),
      json['selectedSchedules']
          .map<SelectedScheduleResponse>(
              (e) => SelectedScheduleResponse.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ScheduleResponse{id: $id, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, selectedSchedules: $selectedSchedules}';
  }
}
