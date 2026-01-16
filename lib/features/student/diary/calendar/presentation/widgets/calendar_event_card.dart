import 'package:flutter/material.dart';
import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';

class CalendarEventCard extends StatelessWidget {
  final CalendarEvent event;

  const CalendarEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.event, color: Color(0xFFB71C1C)),
      title: Text(
        event.title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${event.dateBS} • ${event.daysLeft}d left",
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }
}
