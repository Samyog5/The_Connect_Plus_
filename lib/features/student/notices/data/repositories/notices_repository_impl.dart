import '../../domain/entities/notice.dart';
import '../../domain/repositories/notices_repository.dart';
import '../datasources/notices_remote_data_source.dart';

class NoticesRepositoryImpl implements NoticesRepository {
  final NoticesRemoteDataSource remoteDataSource;

  NoticesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Notice>> getNotices() async {
    return await remoteDataSource.getNotices();
  }

  @override
  Future<void> markAsRead(String id) async {
    // In a real implementation, this would call an API
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
