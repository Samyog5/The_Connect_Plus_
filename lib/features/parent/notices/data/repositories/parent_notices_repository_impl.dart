import 'package:tcp/features/parent/notices/data/datasources/parent_notices_remote_data_source.dart';
import 'package:tcp/features/parent/notices/domain/entities/parent_notice.dart';
import 'package:tcp/features/parent/notices/domain/repositories/parent_notices_repository.dart';

class ParentNoticesRepositoryImpl implements ParentNoticesRepository {
  final ParentNoticesRemoteDataSource remoteDataSource;

  ParentNoticesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ParentNotice>> getNotices() {
    return remoteDataSource.getNotices();
  }
}
