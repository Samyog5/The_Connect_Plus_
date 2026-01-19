import 'package:tcp/features/parent/notices/data/models/parent_notice_model.dart';

abstract class ParentNoticesRemoteDataSource {
  Future<List<ParentNoticeModel>> getNotices();
}
