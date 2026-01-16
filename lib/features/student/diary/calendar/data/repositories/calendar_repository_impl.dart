import 'package:tcp/features/student/diary/calendar/data/datasources/calendar_remote_data_source.dart';
import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';
import 'package:tcp/features/student/diary/calendar/domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDataSource remoteDataSource;

  CalendarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CalendarDay>> getCalendarDays(DateTime month) async {
    return await remoteDataSource.getCalendarDays(month);
  }

  @override
  Future<List<CalendarEvent>> getUpcomingEvents() async {
    return await remoteDataSource.getUpcomingEvents();
  }
}
