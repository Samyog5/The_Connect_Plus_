import '../../domain/entities/diary_item.dart';
import '../../domain/repositories/diary_repository.dart';
import '../datasources/diary_remote_data_source.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryRemoteDataSource remoteDataSource;

  DiaryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DiaryItem>> getDiaryItems() async {
    final diaryItemModels = await remoteDataSource.getDiaryItems();
    return diaryItemModels;
  }
}
