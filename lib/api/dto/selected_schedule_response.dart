import 'availability_response.dart';

class SelectedScheduleResponse {
  final int id;
  final int scheduleId;
  final String username;
  final List<AvailabilityResponse> availabilities;

  SelectedScheduleResponse(
      this.id, this.scheduleId, this.username, this.availabilities);

  factory SelectedScheduleResponse.fromJson(Map<String, dynamic> json) {
    return SelectedScheduleResponse(
      json['id'],
      json['scheduleId'],
      json['username'],
      json['availAbilities']
          .map<AvailabilityResponse>((e) => AvailabilityResponse.fromJson(e))
          .toList(),
    );
  }
}
