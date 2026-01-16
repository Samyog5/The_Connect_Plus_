import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/diary/calendar/domain/usecases/get_calendar_data.dart';
import 'package:tcp/features/student/diary/calendar/presentation/bloc/calendar_event.dart';
import 'package:tcp/features/student/diary/calendar/presentation/bloc/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarBlocEvent, CalendarState> {
  final GetCalendarData getCalendarData;

  CalendarBloc({required this.getCalendarData}) : super(CalendarInitial()) {
    on<LoadCalendarData>(_onLoadCalendarData);
    on<NavigateMonth>(_onNavigateMonth);
    on<ResetToToday>(_onResetToToday);
  }

  DateTime _currentMonth = DateTime.now();

  Future<void> _onLoadCalendarData(
    LoadCalendarData event,
    Emitter<CalendarState> emit,
  ) async {
    _currentMonth = event.month;
    emit(CalendarLoading(selectedMonth: _currentMonth));
    try {
      final calendarData = await getCalendarData(_currentMonth);
      emit(
        CalendarLoaded(
          days: calendarData.days,
          upcomingEvents: calendarData.events,
          selectedMonth: _currentMonth,
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString(), selectedMonth: _currentMonth));
    }
  }

  void _onNavigateMonth(NavigateMonth event, Emitter<CalendarState> emit) {
    final newMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + event.delta,
    );
    add(LoadCalendarData(month: newMonth));
  }

  void _onResetToToday(ResetToToday event, Emitter<CalendarState> emit) {
    add(LoadCalendarData(month: DateTime.now()));
  }
}
