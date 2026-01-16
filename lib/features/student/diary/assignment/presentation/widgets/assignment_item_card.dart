import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcp/features/student/diary/assignment/domain/entities/assignment.dart';

class AssignmentItemCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback? onTap;

  const AssignmentItemCard({super.key, required this.assignment, this.onTap});

  @override
  Widget build(BuildContext context) {
    final diff = assignment.dueDate.difference(DateTime.now());
    final daysLeft = diff.inDays;
    final statusText = assignment.isCompleted
        ? "Completed"
        : (daysLeft < 0 ? "Overdue" : "$daysLeft Days Left");
    final statusColor = assignment.isCompleted
        ? Colors.green
        : (daysLeft < 0 ? Colors.red : const Color(0xFF6366F1));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    assignment.subject,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              assignment.title,
              style: const TextStyle(
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              assignment.remarks,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('MMM dd, yyyy').format(assignment.dueDate),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
