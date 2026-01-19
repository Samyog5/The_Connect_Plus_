import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';
import 'package:tcp/injection_container.dart' as di;
import 'package:tcp/features/parent/attendance/presentation/bloc/parent_attendance_bloc.dart';
import 'package:tcp/features/parent/attendance/presentation/bloc/parent_attendance_event.dart';
import 'package:tcp/features/parent/attendance/presentation/bloc/parent_attendance_state.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';
import 'package:tcp/features/parent/widgets/parent_navbar.dart';

class ParentAttendancePage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const ParentAttendancePage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ParentAttendancePage> createState() => _ParentAttendancePageState();
}

class _ParentAttendancePageState extends State<ParentAttendancePage>
    with TickerProviderStateMixin {
  int _selectedNavIndex = 1;
  late AnimationController _animationController;
  late List<ParentAttendanceRecord> _records;
  late final ParentAttendanceBloc _attendanceBloc;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _records = const [];
    _attendanceBloc = di.sl<ParentAttendanceBloc>()
      ..add(const LoadParentAttendance());

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _attendanceBloc.close();
    super.dispose();
  }

  int get _totalDays => _records.length;
  int get _present =>
      _records.where((r) => r.status == ParentAttendanceStatus.present).length;
  int get _absent =>
      _records.where((r) => r.status == ParentAttendanceStatus.absent).length;
  int get _leave =>
      _records.where((r) => r.status == ParentAttendanceStatus.leave).length;
  double get _attendancePercentage =>
      _totalDays > 0 ? (_present / _totalDays) * 100 : 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _attendanceBloc,
      child: BlocListener<ParentAttendanceBloc, ParentAttendanceState>(
        listener: (context, state) {
          if (!mounted) return;

          if (state is ParentAttendanceLoading) {
            setState(() {
              _isLoading = true;
              _errorMessage = null;
            });
          } else if (state is ParentAttendanceLoaded) {
            setState(() {
              _isLoading = false;
              _errorMessage = null;
              _records = state.records;
            });
          } else if (state is ParentAttendanceError) {
            setState(() {
              _isLoading = false;
              _errorMessage = state.message;
            });
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: const ParentGradientAppBar(title: 'Attendance'),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFB71C1C)),
                )
              : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ParentAttendanceBloc>().add(
                              const LoadParentAttendance(),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTodayStatusCard(),
                      const SizedBox(height: 28),
                      _buildStatsCard(),
                      const SizedBox(height: 28),
                      _buildAttendanceCalendar(),
                      const SizedBox(height: 28),
                      _buildAttendanceList(),
                    ],
                  ),
                ),
          bottomNavigationBar: ParentNavBar(
            selectedIndex: _selectedNavIndex,
            onTabChanged: _handleNavigation,
          ),
        ),
      ),
    );
  }

  Widget _buildTodayStatusCard() {
    final todayRecord = _records.firstWhereOrNull((r) => r.date == '5 Jan');
    final (statusColor, statusLabel) = _getStatusColors(
      todayRecord?.status ?? ParentAttendanceStatus.absent,
    );

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.1, 0.4, curve: Curves.easeOut),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.1, 0.4),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                statusColor.withValues(alpha: 0.1),
                statusColor.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: statusColor.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: statusColor.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Status',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getStatusIcon(
                        todayRecord?.status ?? ParentAttendanceStatus.absent,
                      ),
                      color: statusColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        todayRecord?.subject ?? 'No class scheduled',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.15, 0.45),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _buildStatItem(
                    'Total Days',
                    _totalDays.toString(),
                    const Color(0xFFB71C1C),
                  ),
                  const SizedBox(width: 16),
                  _buildStatItem(
                    'Present',
                    _present.toString(),
                    const Color(0xFF10B981),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatItem(
                    'Absent',
                    _absent.toString(),
                    const Color(0xFFEF4444),
                  ),
                  const SizedBox(width: 16),
                  _buildStatItem(
                    'Leave',
                    _leave.toString(),
                    const Color(0xFFF59E0B),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB71C1C).withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance %',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_attendancePercentage.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${_attendancePercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCalendar() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.25, 0.55),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB71C1C).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Color(0xFFB71C1C),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'January 2026',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildCalendarGrid(),
              const SizedBox(height: 16),
              _buildCalendarLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 31,
      itemBuilder: (context, index) {
        final day = index + 1;
        final recordStatus = _getStatusForDay(day);

        return _buildCalendarDay(day, recordStatus);
      },
    );
  }

  Widget _buildCalendarDay(int day, ParentAttendanceStatus? status) {
    if (status == null) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
          ),
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    final (color, _) = _getStatusColors(status);
    final isToday = day == 5;

    return Container(
      decoration: BoxDecoration(
        color: isToday ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isToday ? color : color.withValues(alpha: 0.3),
        ),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isToday ? Colors.white : color,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem('Present', const Color(0xFF10B981)),
        _buildLegendItem('Absent', const Color(0xFFEF4444)),
        _buildLegendItem('Leave', const Color(0xFFF59E0B)),
        _buildLegendItem('Holiday', const Color(0xFF9CA3AF)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  ParentAttendanceStatus? _getStatusForDay(int day) {
    return _records.firstWhereOrNull((r) {
      final dayNum = int.tryParse(r.date.split(' ')[0]) ?? 0;
      return dayNum == day;
    })?.status;
  }

  Widget _buildAttendanceList() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.35, 0.9, curve: Curves.easeOut),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.35, 0.9),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Attendance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _records.length,
              itemBuilder: (context, index) {
                return _buildAttendanceItem(_records[index], index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceItem(ParentAttendanceRecord record, int index) {
    final (statusColor, statusLabel) = _getStatusColors(record.status);
    final gradient = _getStatusGradient(record.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              _getStatusIcon(record.status),
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.subject ?? 'No subject',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${record.date} • ${record.day}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (record.time != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    record.time!,
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _getStatusColors(ParentAttendanceStatus status) {
    switch (status) {
      case ParentAttendanceStatus.present:
        return (const Color(0xFF10B981), 'Present');
      case ParentAttendanceStatus.absent:
        return (const Color(0xFFEF4444), 'Absent');
      case ParentAttendanceStatus.leave:
        return (const Color(0xFFF59E0B), 'Leave');
      case ParentAttendanceStatus.holiday:
        return (const Color(0xFF9CA3AF), 'Holiday');
    }
  }

  LinearGradient _getStatusGradient(ParentAttendanceStatus status) {
    switch (status) {
      case ParentAttendanceStatus.present:
        return const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ParentAttendanceStatus.absent:
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ParentAttendanceStatus.leave:
        return const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ParentAttendanceStatus.holiday:
        return const LinearGradient(
          colors: [Color(0xFF9CA3AF), Color(0xFF6B7280)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  IconData _getStatusIcon(ParentAttendanceStatus status) {
    switch (status) {
      case ParentAttendanceStatus.present:
        return Icons.check_rounded;
      case ParentAttendanceStatus.absent:
        return Icons.close_rounded;
      case ParentAttendanceStatus.leave:
        return Icons.flight_takeoff_rounded;
      case ParentAttendanceStatus.holiday:
        return Icons.celebration_rounded;
    }
  }

  void _handleNavigation(int index) {
    if (index == _selectedNavIndex) {
      return;
    }

    setState(() => _selectedNavIndex = index);

    final extra = {
      'userName': widget.userName,
      'userAvatar': widget.userAvatar,
    };

    if (index == 0) {
      context.go('/parent/home', extra: extra);
    } else if (index == 1) {
      context.go('/parent/attendance', extra: extra);
    } else if (index == 2) {
      context.go('/parent/notices', extra: extra);
    } else if (index == 3) {
      context.go('/parent/more', extra: extra);
    }
  }
}

extension on List<ParentAttendanceRecord> {
  ParentAttendanceRecord? firstWhereOrNull(
    bool Function(ParentAttendanceRecord) test,
  ) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
