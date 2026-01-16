import 'package:equatable/equatable.dart';

abstract class CalendarBlocEvent extends Equatable {
  const CalendarBlocEvent();

  @override
  List<Object?> get props => [];
}

class LoadCalendarData extends CalendarBlocEvent {
  final DateTime month;

  const LoadCalendarData({required this.month});

  @override
  List<Object?> get props => [month];
}

class NavigateMonth extends CalendarBlocEvent {
  final int delta;

  const NavigateMonth({required this.delta});

  @override
  List<Object?> get props => [delta];
}

class ResetToToday extends CalendarBlocEvent {}
