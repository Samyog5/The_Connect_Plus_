import 'package:flutter/material.dart';
import 'home_section_card.dart';

class RoutineSection extends StatelessWidget {
  const RoutineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      {'time': '09:00 AM', 'subject': 'Mathematics', 'teacher': 'Mr. Sharma'},
      {'time': '10:00 AM', 'subject': 'Science', 'teacher': 'Ms. Pradhan'},
      {'time': '11:30 AM', 'subject': 'English', 'teacher': 'Mrs. Karki'},
    ];

    return HomeSectionCard(
      title: "Today's Routine",
      accentColor: Colors.amber,
      actionLabel: 'Full',
      onAction: () {},
      child: Column(
        children: [
          ...classes.map((cls) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          cls['time']!.split(' ')[0],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          cls['time']!.split(' ')[1],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.amber[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(width: 2, height: 50, color: Colors.amber[300]),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cls['subject']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Teacher: ${cls['teacher']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Lunch Break • 11:30 AM - 12:00 PM',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
