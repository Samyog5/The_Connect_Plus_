import '../entities/notice.dart';
import '../repositories/notices_repository.dart';

class GetNotices {
  final NoticesRepository repository;

  GetNotices(this.repository);

  Future<List<Notice>> call() async {
    return await repository.getNotices();
  }
}
