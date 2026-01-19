import 'package:tcp/features/parent/home/data/datasources/parent_home_remote_data_source.dart';
import 'package:tcp/features/parent/home/data/models/parent_home_dashboard_model.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_fee_info.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_notice.dart';

class ParentHomeRemoteDataSourceImpl implements ParentHomeRemoteDataSource {
  @override
  Future<ParentHomeDashboardModel> getDashboard() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 650));

    return ParentHomeDashboardModel(
      feeInfo: const ParentFeeInfo(
        totalDue: '12,500',
        dueDate: '15 Jan 2026',
        status: 'Pending',
      ),
      notices: const [
        ParentHomeNotice(
          title: 'Parent-Teacher Meeting',
          description:
              'Meeting scheduled this week. Please confirm attendance.',
          time: '2h ago',
        ),
        ParentHomeNotice(
          title: 'Holiday Notice',
          description: 'School will remain closed next Monday.',
          time: '1d ago',
        ),
      ],
    );
  }
}
