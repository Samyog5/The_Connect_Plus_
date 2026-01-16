import 'package:flutter/material.dart';
import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';
import 'calendar_day_widget.dart';

class CalendarGrid extends StatelessWidget {
  final List<CalendarDay> days;

  const CalendarGrid({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    double dayWidth = (MediaQuery.of(context).size.width - 32 - 24 - 24) / 7;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Weekdays
          Row(
            children: daysOfWeek
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 6),
          // Days
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: days.map((day) {
              return CalendarDayWidget(day: day, width: dayWidth, onTap: () {});
            }).toList(),
          ),
        ],
      ),
    );
  }
}
