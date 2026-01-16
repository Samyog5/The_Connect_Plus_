import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';
import 'package:tcp/features/student/diary/calendar/domain/repositories/calendar_repository.dart';

class CalendarData {
  final List<CalendarDay> days;
  final List<CalendarEvent> events;

  CalendarData({required this.days, required this.events});
}

class GetCalendarData {
  final CalendarRepository repository;

  GetCalendarData(this.repository);

  Future<CalendarData> call(DateTime month) async {
    final days = await repository.getCalendarDays(month);
    final events = await repository.getUpcomingEvents();
    return CalendarData(days: days, events: events);
  }
}
