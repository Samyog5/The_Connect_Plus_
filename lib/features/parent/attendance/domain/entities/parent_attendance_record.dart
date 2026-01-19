enum ParentAttendanceStatus { present, absent, leave, holiday }

class ParentAttendanceRecord {
  final String date; // Format: "5 Jan"
  final String day;
  final ParentAttendanceStatus status;
  final String? subject;
  final String? time;

  const ParentAttendanceRecord({
    required this.date,
    required this.day,
    required this.status,
    this.subject,
    this.time,
  });
}
