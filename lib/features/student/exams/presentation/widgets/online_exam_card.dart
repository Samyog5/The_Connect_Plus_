import 'package:flutter/material.dart';

class OnlineExamCard extends StatelessWidget {
  final String subject;
  final String date;
  final String time;
  final String duration;
  final int totalMarks;
  final int? obtainedMarks;
  final ExamStatus status;
  final VoidCallback onTap;

  const OnlineExamCard({
    super.key,
    required this.subject,
    required this.date,
    required this.time,
    required this.duration,
    required this.totalMarks,
    required this.status,
    required this.onTap,
    this.obtainedMarks,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);
    final statusText = _getStatusText(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: statusColor.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (status == ExamStatus.completed && obtainedMarks != null)
                      Text(
                        '$obtainedMarks / $totalMarks',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.calendar_today_rounded,
                        label: date,
                      ),
                    ),
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.access_time_rounded,
                        label: time,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.timer_outlined,
                        label: duration,
                      ),
                    ),
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.grade_outlined,
                        label: '$totalMarks Marks',
                      ),
                    ),
                  ],
                ),
                if (status == ExamStatus.live) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: const Text('Start Exam Now'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ExamStatus status) {
    switch (status) {
      case ExamStatus.live:
        return const Color(0xFFEF4444);
      case ExamStatus.upcoming:
        return const Color(0xFF3B82F6);
      case ExamStatus.completed:
        return const Color(0xFF10B981);
    }
  }

  String _getStatusText(ExamStatus status) {
    switch (status) {
      case ExamStatus.live:
        return 'LIVE NOW';
      case ExamStatus.upcoming:
        return 'UPCOMING';
      case ExamStatus.completed:
        return 'COMPLETED';
    }
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

enum ExamStatus { live, upcoming, completed }
