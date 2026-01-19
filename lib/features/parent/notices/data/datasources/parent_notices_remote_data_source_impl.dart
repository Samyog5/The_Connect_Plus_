import 'package:tcp/features/parent/notices/data/datasources/parent_notices_remote_data_source.dart';
import 'package:tcp/features/parent/notices/data/models/parent_notice_model.dart';

class ParentNoticesRemoteDataSourceImpl implements ParentNoticesRemoteDataSource {
  @override
  Future<List<ParentNoticeModel>> getNotices() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 700));

    return const [
      ParentNoticeModel(
        id: '1',
        title: 'Parent-Teacher Meeting',
        description:
            'PTM scheduled for Jan 12, 2026. Please confirm attendance.',
        date: 'Jan 6, 2026',
        isUnread: true,
      ),
      ParentNoticeModel(
        id: '2',
        title: 'Exam Fee Reminder',
        description: 'Exam fee payment window closes on Jan 15, 2026.',
        date: 'Jan 5, 2026',
      ),
      ParentNoticeModel(
        id: '3',
        title: 'Holiday Announcement',
        description: 'School will remain closed on Jan 10, 2026.',
        date: 'Jan 4, 2026',
      ),
    ];
  }
}
