import 'package:tcp/features/parent/notices/domain/entities/parent_notice.dart';
import 'package:tcp/features/parent/notices/domain/repositories/parent_notices_repository.dart';

class GetParentNotices {
  final ParentNoticesRepository repository;

  GetParentNotices(this.repository);

  Future<List<ParentNotice>> call() {
    return repository.getNotices();
  }
}
