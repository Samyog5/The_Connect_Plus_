import '../entities/diary_item.dart';

abstract class DiaryRepository {
  Future<List<DiaryItem>> getDiaryItems();
}
