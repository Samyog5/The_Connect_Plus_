import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_section_card.dart';

class NoticesSection extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const NoticesSection({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final notices = [
      {
        'title': 'Winter Vacation Announcement',
        'description': 'School closed Jan 15-25. Classes resume Jan 27.',
        'time': '2 hours ago',
      },
      {
        'title': 'Exam Schedule Released',
        'description': 'Final exams from March 1st to March 15th.',
        'time': '1 day ago',
      },
    ];

    return HomeSectionCard(
      title: 'Current Notices',
      accentColor: Colors.blue,
      actionLabel: 'View All',
      onAction: () => context.push('/notices'),
      child: Column(
        children: notices.map((notice) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notice['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notice['description']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Posted ${notice['time']}',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
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
