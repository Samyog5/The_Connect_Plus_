import 'package:tcp/features/parent/diary/domain/entities/parent_diary_destination.dart';

class ParentDiaryItem {
  final ParentDiaryDestination destination;
  final String label;

  const ParentDiaryItem({
    required this.destination,
    required this.label,
  });
}
