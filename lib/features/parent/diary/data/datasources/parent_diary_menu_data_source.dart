import 'package:tcp/features/parent/diary/domain/entities/parent_diary_item.dart';

abstract class ParentDiaryMenuDataSource {
  Future<List<ParentDiaryItem>> getDiaryItems();
}
