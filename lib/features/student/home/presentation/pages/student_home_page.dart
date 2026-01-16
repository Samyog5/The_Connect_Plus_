import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/features/student/widgets/custom_navbar.dart';
import '../widgets/welcome_card.dart';
import '../widgets/fee_section.dart';
import '../widgets/notices_section.dart';
import '../widgets/routine_section.dart';
import '../widgets/assignments_section.dart';

class StudentHomePage extends StatefulWidget {
  final String userName;
  final String userRole;
  final String userAvatar;
  final String className;

  const StudentHomePage({
    super.key,
    required this.userName,
    required this.userRole,
    required this.userAvatar,
    this.className = 'Class 10 - A',
  });

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${days[now.weekday % 7]}, ${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  Widget _buildAnimatedWidget(int index, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval((1 / 5) * index, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
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

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 8,
        toolbarHeight: 72,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB71C1C).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'EduConnect - Student',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (!isMobile) ...[
              Text(
                _getCurrentDate(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeOutBack,
                  ),
                ),
                child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(widget.userAvatar),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedWidget(0, WelcomeCard(userName: widget.userName)),
            const SizedBox(height: 24),
            _buildAnimatedWidget(1, const FeeSection()),
            const SizedBox(height: 24),
            _buildAnimatedWidget(
              2,
              NoticesSection(
                userName: widget.userName,
                userAvatar: widget.userAvatar,
              ),
            ),
            const SizedBox(height: 24),
            _buildAnimatedWidget(3, const RoutineSection()),
            const SizedBox(height: 24),
            _buildAnimatedWidget(4, const AssignmentsSection()),
            const SizedBox(height: 24),
            // Re-adding Calendar placeholder if needed, or removing if not yet implemented as a section
            // _buildAnimatedWidget(5, _buildCalendarWidget()),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: (index) {
          setState(() => _selectedNavIndex = index);

          switch (index) {
            case 0:
              GoRouter.of(context).go('/home');
              break;
            case 1:
              GoRouter.of(context).go(
                '/diary',
              ); // Changed from /schedule to /diary based on bottom nav common pattern
              break;
            case 2:
              GoRouter.of(
                context,
              ).go('/schedule'); // Assuming 3rd item is schedule
              break;
            case 3:
              GoRouter.of(context).go('/more');
              break;
          }
        },
        isBottomNav: true,
      ),
    );
  }
}
