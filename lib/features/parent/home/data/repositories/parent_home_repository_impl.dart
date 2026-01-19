import 'package:tcp/features/parent/home/data/datasources/parent_home_remote_data_source.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_dashboard.dart';
import 'package:tcp/features/parent/home/domain/repositories/parent_home_repository.dart';

class ParentHomeRepositoryImpl implements ParentHomeRepository {
  final ParentHomeRemoteDataSource remoteDataSource;

  ParentHomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ParentHomeDashboard> getDashboard() {
    return remoteDataSource.getDashboard();
  }
}
