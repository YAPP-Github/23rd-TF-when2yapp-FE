class AvailabilityResponse {
  final int id;
  final int selectedScheduleId;
  final DateTime startTime;
  final DateTime endTime;

  AvailabilityResponse(
      this.id, this.selectedScheduleId, this.startTime, this.endTime);

  factory AvailabilityResponse.fromJson(Map<String, dynamic> json) {
    return AvailabilityResponse(
      json['id'],
      json['selectedScheduleId'],
      DateTime.parse(json['startTime']),
      DateTime.parse(json['endTime']),
    );
  }

  @override
  String toString() {
    return 'AvailabilityResponse{id: $id, selectedScheduleId: $selectedScheduleId, startTime: $startTime, endTime: $endTime}';
  }
}
