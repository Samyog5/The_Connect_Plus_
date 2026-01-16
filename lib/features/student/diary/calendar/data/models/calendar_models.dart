import 'package:tcp/features/student/diary/calendar/domain/entities/calendar_entities.dart';

class CalendarDayModel extends CalendarDay {
  const CalendarDayModel({
    required super.dayBS,
    required super.dayAD,
    super.isToday,
    super.isHoliday,
    super.isCurrentMonth,
    super.tithi,
    super.hasEvent,
  });

  factory CalendarDayModel.fromJson(Map<String, dynamic> json) {
    return CalendarDayModel(
      dayBS: json['dayBS'] as int,
      dayAD: json['dayAD'] as int,
      isToday: json['isToday'] as bool? ?? false,
      isHoliday: json['isHoliday'] as bool? ?? false,
      isCurrentMonth: json['isCurrentMonth'] as bool? ?? true,
      tithi: json['tithi'] as String?,
      hasEvent: json['hasEvent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayBS': dayBS,
      'dayAD': dayAD,
      'isToday': isToday,
      'isHoliday': isHoliday,
      'isCurrentMonth': isCurrentMonth,
      'tithi': tithi,
      'hasEvent': hasEvent,
    };
  }
}

class CalendarEventModel extends CalendarEvent {
  const CalendarEventModel({
    required super.id,
    required super.title,
    required super.dateBS,
    required super.daysLeft,
    super.description,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      dateBS: json['dateBS'] as String,
      daysLeft: json['daysLeft'] as int,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateBS': dateBS,
      'daysLeft': daysLeft,
      'description': description,
    };
  }
}
