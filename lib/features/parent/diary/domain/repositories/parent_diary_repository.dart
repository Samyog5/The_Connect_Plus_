import 'package:tcp/features/parent/diary/domain/entities/parent_diary_item.dart';

abstract class ParentDiaryRepository {
  Future<List<ParentDiaryItem>> getDiaryItems();
}
