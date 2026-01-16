import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';
import 'package:tcp/features/student/widgets/custom_navbar.dart';

import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_state.dart';
import '../widgets/attendance_stats_card.dart';
import '../widgets/attendance_status_card.dart';
import '../widgets/attendance_calendar.dart';
import '../widgets/attendance_item_card.dart';
import '../widgets/attendance_loading_shimmer.dart';

const _BACKGROUND_GRADIENT = LinearGradient(
  colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class StudentAttendancePage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const StudentAttendancePage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage>
    with TickerProviderStateMixin {
  int _selectedNavIndex = 3;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: _BACKGROUND_GRADIENT),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 60,
                  bottom: 100,
                ),
                child: AttendanceLoadingShimmer(),
              );
            }

            if (state is AttendanceError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            }

            if (state is AttendanceLoaded) {
              final records = state.records;
              final todayStatus = records.isNotEmpty
                  ? records.first.status
                  : AttendanceStatus.absent;
              final todaySubject = records.isNotEmpty
                  ? records.first.subject
                  : null;

              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 60,
                  bottom: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedSection(0, _buildPageHeader()),
                    const SizedBox(height: 28),
                    _buildAnimatedSection(
                      1,
                      AttendanceStatusCard(
                        status: todayStatus,
                        subject: todaySubject,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildAnimatedSection(
                      2,
                      AttendanceStatsCard(
                        totalDays: state.totalDays,
                        present: state.totalPresent,
                        absent: state.totalAbsent,
                        leave: state.totalLeave,
                        percentage: state.attendancePercentage,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildAnimatedSection(
                      3,
                      AttendanceCalendar(
                        records: records,
                        monthYear: 'January 2026',
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildAnimatedSection(4, _buildRecentTitle()),
                    const SizedBox(height: 16),
                    ...List.generate(records.length, (index) {
                      return _buildAnimatedSection(
                        5 + index,
                        AttendanceItemCard(record: records[index]),
                      );
                    }),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: (index) {
          setState(() => _selectedNavIndex = index);
          _handleNavigation(index);
        },
        isBottomNav: true,
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == 0) context.go('/home');
    if (index == 1) context.go('/schedule');
    if (index == 2) context.go('/notices');
    if (index == 3) context.go('/more');
  }

  Widget _buildAnimatedSection(int index, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (1 / 10) * index.clamp(0, 9),
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (1 / 10) * index.clamp(0, 9),
                  1.0,
                  curve: Curves.easeOut,
                ),
              ),
            ),
        child: child,
      ),
    );
  }

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Attendance',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Track your attendance and performance',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTitle() {
    return Text(
      'Recent Attendance',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.grey[900],
      ),
    );
  }
}
