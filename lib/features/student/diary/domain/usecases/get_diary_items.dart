import '../entities/diary_item.dart';
import '../repositories/diary_repository.dart';

class GetDiaryItems {
  final DiaryRepository repository;

  GetDiaryItems(this.repository);

  Future<List<DiaryItem>> call() async {
    return await repository.getDiaryItems();
  }
}
