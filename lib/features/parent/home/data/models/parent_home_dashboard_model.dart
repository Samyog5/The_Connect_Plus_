import 'package:tcp/features/parent/home/domain/entities/parent_fee_info.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_dashboard.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_notice.dart';

class ParentHomeDashboardModel extends ParentHomeDashboard {
  const ParentHomeDashboardModel({
    required ParentFeeInfo feeInfo,
    required List<ParentHomeNotice> notices,
  }) : super(feeInfo: feeInfo, notices: notices);
}
