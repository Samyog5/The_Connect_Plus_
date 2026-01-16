import '../entities/notice.dart';

abstract class NoticesRepository {
  Future<List<Notice>> getNotices();
  Future<void> markAsRead(String id);
}
