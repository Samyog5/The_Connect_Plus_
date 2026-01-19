import 'package:tcp/features/parent/notices/domain/entities/parent_notice.dart';

abstract class ParentNoticesRepository {
  Future<List<ParentNotice>> getNotices();
}
