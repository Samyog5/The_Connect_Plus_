import 'package:tcp/features/parent/home/domain/entities/parent_home_dashboard.dart';

abstract class ParentHomeRepository {
  Future<ParentHomeDashboard> getDashboard();
}
