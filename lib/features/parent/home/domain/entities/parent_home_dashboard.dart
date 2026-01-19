import 'package:tcp/features/parent/home/domain/entities/parent_fee_info.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_notice.dart';

class ParentHomeDashboard {
  final ParentFeeInfo feeInfo;
  final List<ParentHomeNotice> notices;

  const ParentHomeDashboard({
    required this.feeInfo,
    required this.notices,
  });
}
