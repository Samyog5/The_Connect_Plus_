import 'package:tcp/features/parent/notices/domain/entities/parent_notice.dart';

class ParentNoticeModel extends ParentNotice {
  const ParentNoticeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    super.isUnread,
  });
}
