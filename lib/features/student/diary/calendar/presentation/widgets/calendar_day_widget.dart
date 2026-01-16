import 'package:flutter/material.dart';
import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay day;
  final double width;
  final VoidCallback? onTap;

  const CalendarDayWidget({
    super.key,
    required this.day,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    if (day.isToday) {
      bgColor = const Color(0xFFB71C1C);
      textColor = Colors.white;
    } else if (day.isHoliday) {
      bgColor = Colors.red[50]!;
      textColor = Colors.red;
    } else if (!day.isCurrentMonth) {
      bgColor = Colors.grey.shade100;
      textColor = Colors.grey;
    } else {
      bgColor = Colors.white;
      textColor = Colors.black87;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: width,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: day.hasEvent
              ? Border.all(color: Colors.blue, width: 1.2)
              : null,
          boxShadow: day.isToday
              ? [BoxShadow(color: Colors.red.withOpacity(0.2), blurRadius: 6)]
              : [],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${day.dayBS}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${day.dayAD}",
                    style: TextStyle(
                      fontSize: 9,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (day.tithi != null)
              Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    day.tithi!,
                    style: const TextStyle(fontSize: 8, color: Colors.grey),
                  ),
                ),
              ),
            if (day.hasEvent)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
