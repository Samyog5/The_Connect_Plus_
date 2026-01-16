import 'package:tcp/features/student/diary/calendar/data/models/calendar_models.dart';

abstract class CalendarRemoteDataSource {
  Future<List<CalendarDayModel>> getCalendarDays(DateTime month);
  Future<List<CalendarEventModel>> getUpcomingEvents();
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  @override
  Future<List<CalendarDayModel>> getCalendarDays(DateTime month) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data based on the original sample
    return List.generate(
      35,
      (index) => CalendarDayModel(
        dayBS: index + 1,
        dayAD: index + 1,
        isToday: index == 2,
        isHoliday: index % 6 == 0,
        hasEvent: index % 5 == 0,
        tithi: index == 5 ? 'Aunshi' : null,
      ),
    );
  }

  @override
  Future<List<CalendarEventModel>> getUpcomingEvents() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      const CalendarEventModel(
        id: "1",
        title: "Guru Govind Singh Jayanti",
        dateBS: "Poush 21, 2082",
        daysLeft: 2,
        description: "Guru Govind Singh Jayanti - Cultural Celebration",
      ),
      const CalendarEventModel(
        id: "2",
        title: "Mid Term Exam",
        dateBS: "Poush 25, 2082",
        daysLeft: 6,
        description: "Mid term examination for all classes.",
      ),
    ];
  }
}
