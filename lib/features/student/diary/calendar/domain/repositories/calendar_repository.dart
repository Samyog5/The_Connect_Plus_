import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';

abstract class CalendarRepository {
  Future<List<CalendarDay>> getCalendarDays(DateTime month);
  Future<List<CalendarEvent>> getUpcomingEvents();
}
