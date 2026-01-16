import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DiaryItem extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String count;
  final IconData icon;
  final Color color;
  final String route;

  const DiaryItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.count,
    required this.icon,
    required this.color,
    required this.route,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    count,
    icon,
    color,
    route,
  ];
}
