import 'package:flutter/material.dart';
import 'package:tcp/features/student/widgets/custom_navbar.dart';
import 'package:go_router/go_router.dart';
import '../../homework/presentation/pages/student_homework_page.dart';

class StudentDiaryPage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const StudentDiaryPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<StudentDiaryPage> createState() => _StudentDiaryPageState();
}

class _StudentDiaryPageState extends State<StudentDiaryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedNavIndex = 3; // 0: Home, 1: Schedule, 2: Notices, 3: More

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNavChanged(int index) {
    setState(() {
      _selectedNavIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/schedule');
        break;
      case 2:
        context.go('/notices');
        break;
      case 3:
        context.go('/more');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'My Diary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedSection(0, _buildSectionTitle('Daily Updates')),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildAnimatedSection(
                  1,
                  _buildDiaryCard(
                    title: 'Homework',
                    icon: Icons.menu_book_rounded,
                    color: Colors.blue,
                    count: '3 Tasks',
                    description: 'Daily homework tasks',
                    onTap: () => context.push('/homework'),
                  ),
                ),
                _buildAnimatedSection(
                  2,
                  _buildDiaryCard(
                    title: 'Assignments',
                    icon: Icons.assignment_rounded,
                    color: Colors.orange,
                    count: '2 Pending',
                    description: 'Project submissions',
                    onTap: () => context.push(
                      '/assignments',
                    ), // you can route to assignments page later
                  ),
                ),
                _buildAnimatedSection(
                  3,
                  _buildDiaryCard(
                    title: 'Routine',
                    icon: Icons.schedule_rounded,
                    color: Colors.green,
                    count: 'Today',
                    description: 'Class schedule',
                    onTap: () => context.go('/schedule'),
                  ),
                ),
                _buildAnimatedSection(
                  4,
                  _buildDiaryCard(
                    title: 'Diary Sign',
                    icon: Icons.draw_rounded,
                    color: Colors.purple,
                    count: 'Required',
                    description: 'Parent signature',
                    onTap: () {}, // you can route to diary sign page later
                  ),
                ),
                _buildAnimatedSection(
                  5,
                  _buildDiaryCard(
                    title: 'Institute Calendar',
                    icon: Icons.calendar_month_rounded,
                    color: Colors.red,
                    count: 'Events',
                    description: 'View upcoming institute events',
                    onTap: () => context.push(
                      '/calendar',
                    ), // define /calendar in GoRouter
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: _onNavChanged,
        isBottomNav: true,
      ),
    );
  }

  // ------------------ Helper Widgets ------------------

  Widget _buildAnimatedSection(int index, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval((1 / 6) * index, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (1 / 6) * index,
                  1.0,
                  curve: Curves.easeOutCubic,
                ),
              ),
            ),
        child: child,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDiaryCard({
    required String title,
    required IconData icon,
    required Color color,
    required String count,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
