import 'package:flutter/material.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

class AttendanceStatusCard extends StatelessWidget {
  final AttendanceStatus status;
  final String? subject;

  const AttendanceStatusCard({super.key, required this.status, this.subject});

  @override
  Widget build(BuildContext context) {
    final (statusColor, statusLabel) = _getStatusColors(status);
    final statusIcon = _getStatusIcon(status);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor.withOpacity(0.1), statusColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Status",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(statusIcon, color: statusColor, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: statusColor,
                    ),
                  ),
                  Text(
                    subject ?? 'No class scheduled',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  (Color, String) _getStatusColors(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => (const Color(0xFF10B981), 'Present'),
      AttendanceStatus.absent => (const Color(0xFFEF4444), 'Absent'),
      AttendanceStatus.leave => (const Color(0xFFF59E0B), 'On Leave'),
      AttendanceStatus.holiday => (const Color(0xFF9CA3AF), 'Holiday'),
    };
  }

  IconData _getStatusIcon(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => Icons.check_circle_rounded,
      AttendanceStatus.absent => Icons.cancel_rounded,
      AttendanceStatus.leave => Icons.time_to_leave_rounded,
      AttendanceStatus.holiday => Icons.event_available_rounded,
    };
  }
}
