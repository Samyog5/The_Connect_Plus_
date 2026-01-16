import 'package:flutter/material.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

class AttendanceCalendar extends StatelessWidget {
  final List<AttendanceRecord> records;
  final String monthYear;

  const AttendanceCalendar({
    super.key,
    required this.records,
    required this.monthYear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            monthYear,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              final day = index + 1;
              final status = _getStatusForDay(day);
              final (color, _) = _getStatusColors(
                status ?? AttendanceStatus.absent,
              );
              final isToday =
                  day == DateTime.now().day &&
                  monthYear.contains("Jan"); // Mock logic

              return Container(
                decoration: BoxDecoration(
                  color: isToday ? color : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isToday ? color : color.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isToday ? Colors.white : color,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const _CalendarLegend(),
        ],
      ),
    );
  }

  AttendanceStatus? _getStatusForDay(int day) {
    for (var record in records) {
      final recordDay = int.tryParse(record.date.split(' ')[0]) ?? 0;
      if (recordDay == day) return record.status;
    }
    return null;
  }

  (Color, String) _getStatusColors(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => (const Color(0xFF10B981), 'Present'),
      AttendanceStatus.absent => (const Color(0xFFEF4444), 'Absent'),
      AttendanceStatus.leave => (const Color(0xFFF59E0B), 'On Leave'),
      AttendanceStatus.holiday => (const Color(0xFF9CA3AF), 'Holiday'),
    };
  }
}

class _CalendarLegend extends StatelessWidget {
  const _CalendarLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem('Present', const Color(0xFF10B981)),
        _buildLegendItem('Absent', const Color(0xFFEF4444)),
        _buildLegendItem('Leave', const Color(0xFFF59E0B)),
        _buildLegendItem('Holiday', const Color(0xFF9CA3AF)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
