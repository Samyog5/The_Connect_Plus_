import 'package:equatable/equatable.dart';

class CalendarDay extends Equatable {
  final int dayBS;
  final int dayAD;
  final bool isToday;
  final bool isHoliday;
  final bool isCurrentMonth;
  final String? tithi;
  final bool hasEvent;

  const CalendarDay({
    required this.dayBS,
    required this.dayAD,
    this.isToday = false,
    this.isHoliday = false,
    this.isCurrentMonth = true,
    this.tithi,
    this.hasEvent = false,
  });

  @override
  List<Object?> get props => [
    dayBS,
    dayAD,
    isToday,
    isHoliday,
    isCurrentMonth,
    tithi,
    hasEvent,
  ];
}

class CalendarEvent extends Equatable {
  final String id;
  final String title;
  final String dateBS;
  final int daysLeft;
  final String? description;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.dateBS,
    required this.daysLeft,
    this.description,
  });

  @override
  List<Object?> get props => [id, title, dateBS, daysLeft, description];
}
