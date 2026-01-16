import 'package:flutter/material.dart';
import 'home_section_card.dart';

class AssignmentsSection extends StatelessWidget {
  const AssignmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final assignments = [
      {
        'title': 'Mathematics Assignment',
        'subject': 'Mathematics',
        'description': 'Complete chapter 5 exercises',
        'dueDate': 'Jan 10, 2026',
        'status': 'Pending',
      },
      {
        'title': 'English Essay',
        'subject': 'English',
        'description': 'Write an essay on "Technology and Society"',
        'dueDate': 'Jan 12, 2026',
        'status': 'In Progress',
      },
      {
        'title': 'Science Project',
        'subject': 'Science',
        'description': 'Create a model of solar system',
        'dueDate': 'Jan 15, 2026',
        'status': 'Pending',
      },
    ];

    return HomeSectionCard(
      title: 'Assignments',
      accentColor: Colors.purple,
      actionLabel: 'View All',
      onAction: () {},
      child: Column(
        children: assignments.map((assignment) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.assignment_outlined,
                    color: Colors.purple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        assignment['description']!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Due: ${assignment['dueDate']}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: assignment['status'] == 'Pending'
                                  ? Colors.orange[50]
                                  : Colors.blue[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              assignment['status']!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: assignment['status'] == 'Pending'
                                    ? Colors.orange[700]
                                    : Colors.blue[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
