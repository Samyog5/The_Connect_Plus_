import 'package:flutter/material.dart';
import '../../domain/entities/diary_item.dart';

class DiaryItemModel extends DiaryItem {
  const DiaryItemModel({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.count,
    required super.icon,
    required super.color,
    required super.route,
  });

  factory DiaryItemModel.fromJson(Map<String, dynamic> json) {
    return DiaryItemModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      count: json['count'] as String,
      icon: _iconFromString(json['icon'] as String),
      color: _colorFromString(json['color'] as String),
      route: json['route'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'count': count,
      'icon': _iconToString(icon),
      'color': _colorToString(color),
      'route': route,
    };
  }

  static IconData _iconFromString(String iconName) {
    switch (iconName) {
      case 'menu_book_rounded':
        return Icons.menu_book_rounded;
      case 'assignment_rounded':
        return Icons.assignment_rounded;
      case 'schedule_rounded':
        return Icons.schedule_rounded;
      case 'draw_rounded':
        return Icons.draw_rounded;
      case 'calendar_month_rounded':
        return Icons.calendar_month_rounded;
      default:
        return Icons.help_outline;
    }
  }

  static String _iconToString(IconData icon) {
    if (icon == Icons.menu_book_rounded) return 'menu_book_rounded';
    if (icon == Icons.assignment_rounded) return 'assignment_rounded';
    if (icon == Icons.schedule_rounded) return 'schedule_rounded';
    if (icon == Icons.draw_rounded) return 'draw_rounded';
    if (icon == Icons.calendar_month_rounded) return 'calendar_month_rounded';
    return 'help_outline';
  }

  static Color _colorFromString(String colorName) {
    switch (colorName) {
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static String _colorToString(Color color) {
    if (color == Colors.blue) return 'blue';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.green) return 'green';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.red) return 'red';
    return 'grey';
  }
}
