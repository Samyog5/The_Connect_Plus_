import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/core/utils/avatar_image_provider.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_fee_info.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_notice.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';
import 'package:tcp/features/parent/widgets/parent_navbar.dart';

class ParentHomePage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const ParentHomePage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  int _selectedNavIndex = 0;

  final ParentFeeInfo _feeInfo = const ParentFeeInfo(
    totalDue: '12,500',
    dueDate: '15 Jan 2026',
    status: 'Pending',
  );

  final List<ParentHomeNotice> _homeNotices = const [
    ParentHomeNotice(
      title: 'Parent-Teacher Meeting',
      description: 'Meeting scheduled this week. Please confirm attendance.',
      time: '2h ago',
    ),
    ParentHomeNotice(
      title: 'Holiday Notice',
      description: 'School will remain closed next Monday.',
      time: '1d ago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const ParentGradientAppBar(title: 'Home'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedWidget(0, _buildWelcomeCard()),
            const SizedBox(height: 24),
            _buildAnimatedWidget(1, _buildFeeWidget()),
            const SizedBox(height: 24),
            _buildAnimatedWidget(2, _buildAttendanceWidget()),
            const SizedBox(height: 24),
            _buildAnimatedWidget(3, _buildNoticesWidget()),
          ],
        ),
      ),
      bottomNavigationBar: ParentNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: _handleNavigation,
      ),
    );
  }

  ImageProvider _userAvatarProvider() => avatarImageProvider(widget.userAvatar);

  Map<String, String> _navExtra() => {
    'userName': widget.userName,
    'userAvatar': widget.userAvatar,
  };

  Widget _buildAnimatedWidget(int index, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval((1 / 5) * index, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (1 / 5) * index,
                  1.0,
                  curve: Curves.easeOutCubic,
                ),
              ),
            ),
        child: child,
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFB71C1C).withValues(alpha: 0.1),
                    const Color(0xFFB71C1C).withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning, ${widget.userName}!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Here's what's happening with your child today.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFB71C1C).withValues(alpha: 0.30),
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: _userAvatarProvider(),
                  backgroundColor: const Color(0xFFF8FAFC),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onPayNowPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment flow is not connected yet.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildFeeWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB71C1C),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Fee Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFB71C1C).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: const Color(0xFFB71C1C).withValues(alpha: 0.18),
                  ),
                ),
                child: Text(
                  _feeInfo.status,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Due',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _feeInfo.totalDue,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Due: ${_feeInfo.dueDate}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _onPayNowPressed,
                  icon: const Icon(Icons.payments_rounded, size: 18),
                  label: const Text('Pay Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB71C1C),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Attendance Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () =>
                    context.go('/parent/attendance', extra: _navExtra()),
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
                label: const Text(
                  'View Details',
                  style: TextStyle(fontSize: 10),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFB71C1C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Month',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Present: 18  •  Absent: 2',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red[100]!),
                  ),
                  child: const Text(
                    '90%',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticesWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Current Notices',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () =>
                    context.go('/parent/notices', extra: _navExtra()),
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
                label: const Text('View All', style: TextStyle(fontSize: 10)),
                style: TextButton.styleFrom(foregroundColor: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._homeNotices.map((notice) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notice.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notice.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Posted ${notice.time}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == _selectedNavIndex) {
      return;
    }

    setState(() => _selectedNavIndex = index);

    final extra = _navExtra();

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
