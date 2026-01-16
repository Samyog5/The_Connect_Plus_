import 'package:equatable/equatable.dart';
import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {
  final DateTime selectedMonth;

  const CalendarLoading({required this.selectedMonth});

  @override
  List<Object?> get props => [selectedMonth];
}

class CalendarLoaded extends CalendarState {
  final List<CalendarDay> days;
  final List<CalendarEvent> upcomingEvents;
  final DateTime selectedMonth;

  const CalendarLoaded({
    required this.days,
    required this.upcomingEvents,
    required this.selectedMonth,
  });

  CalendarEvent? get todaysHighlight {
    // For demo purposes, matching the static date from earlier
    // In a real app, this would check against DateTime.now()
    return upcomingEvents.isEmpty ? null : upcomingEvents.first;
  }

  @override
  List<Object?> get props => [days, upcomingEvents, selectedMonth];
}

class CalendarError extends CalendarState {
  final String message;
  final DateTime selectedMonth;

  const CalendarError(this.message, {required this.selectedMonth});

  @override
  List<Object?> get props => [message, selectedMonth];
}
