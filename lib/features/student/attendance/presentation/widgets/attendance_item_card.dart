import 'package:flutter/material.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

class AttendanceItemCard extends StatelessWidget {
  final AttendanceRecord record;

  const AttendanceItemCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final (statusColor, statusLabel) = _getStatusColors(record.status);
    final statusIcon = _getStatusIcon(record.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [statusColor, statusColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(statusIcon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.subject ?? 'Holiday / Event',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${record.date} • ${record.day}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (record.time != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    record.time!,
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
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
