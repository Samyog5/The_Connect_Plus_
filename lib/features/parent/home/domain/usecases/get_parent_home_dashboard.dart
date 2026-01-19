import 'package:tcp/features/parent/home/domain/entities/parent_home_dashboard.dart';
import 'package:tcp/features/parent/home/domain/repositories/parent_home_repository.dart';

class GetParentHomeDashboard {
  final ParentHomeRepository repository;

  GetParentHomeDashboard(this.repository);

  Future<ParentHomeDashboard> call() {
    return repository.getDashboard();
  }
}
