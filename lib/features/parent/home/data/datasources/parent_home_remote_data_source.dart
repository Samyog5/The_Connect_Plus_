import 'package:tcp/features/parent/home/data/models/parent_home_dashboard_model.dart';

abstract class ParentHomeRemoteDataSource {
  Future<ParentHomeDashboardModel> getDashboard();
}
