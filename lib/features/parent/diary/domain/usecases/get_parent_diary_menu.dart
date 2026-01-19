import 'package:tcp/features/parent/diary/domain/entities/parent_diary_item.dart';
import 'package:tcp/features/parent/diary/domain/repositories/parent_diary_repository.dart';

class GetParentDiaryMenu {
  final ParentDiaryRepository repository;

  GetParentDiaryMenu(this.repository);

  Future<List<ParentDiaryItem>> call() {
    return repository.getDiaryItems();
  }
}
