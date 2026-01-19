import 'package:tcp/features/parent/diary/data/datasources/parent_diary_menu_data_source.dart';
import 'package:tcp/features/parent/diary/domain/entities/parent_diary_item.dart';
import 'package:tcp/features/parent/diary/domain/repositories/parent_diary_repository.dart';

class ParentDiaryRepositoryImpl implements ParentDiaryRepository {
  final ParentDiaryMenuDataSource dataSource;

  ParentDiaryRepositoryImpl(this.dataSource);

  @override
  Future<List<ParentDiaryItem>> getDiaryItems() {
    return dataSource.getDiaryItems();
  }
}
