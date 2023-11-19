class When2YappTime implements Comparable<When2YappTime> {
  final int hour;
  final int minute;

  When2YappTime(this.hour, this.minute);

  static When2YappTime from(DateTime dateTime) {
    return When2YappTime(dateTime.hour, dateTime.minute);
  }

  When2YappTime addMinute(int minute) {
    int sum = this.minute + minute;
    return When2YappTime(hour + (sum / 60).floor(), sum % 60);
  }

  @override
  int compareTo(When2YappTime other) {
    if (hour > other.hour) {
      return 1;
    }
    if (hour < other.hour) {
      return -1;
    }
    return minute.compareTo(other.minute);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is When2YappTime &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  bool operator <(When2YappTime other) => compareTo(other) < 0;

  bool operator <=(When2YappTime other) => compareTo(other) <= 0;

  bool operator >(When2YappTime other) => compareTo(other) > 0;

  bool operator >=(When2YappTime other) => compareTo(other) >= 0;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() {
    return 'When2YappTime{hour: $hour, minute: $minute}';
  }
}
