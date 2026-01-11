import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/features/parent/widgets/parent_navbar.dart';
import '../../../diary/presentation/pages/parent_diary_page.dart';

import 'parent_educational_news_page.dart';
import 'parent_elearning_page.dart';
import 'parent_events_activities_page.dart';
import 'parent_exam_management_page.dart';
import 'parent_fee_management_page.dart';
import 'parent_head_of_institute_page.dart';
import 'parent_institute_information_page.dart';
import 'parent_invitations_greetings_page.dart';
import 'parent_learning_materials_page.dart';
import 'parent_library_page.dart';
import 'parent_others_page.dart';
import 'parent_vehicle_management_page.dart';
import 'parent_zoom_class_page.dart';

class ParentMorePage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const ParentMorePage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ParentMorePage> createState() => _ParentMorePageState();
}

class _ParentMorePageState extends State<ParentMorePage>
    with TickerProviderStateMixin {
  final int _selectedNavIndex = 3;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 750),
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
    final isMobile = MediaQuery.of(context).size.width < 768;

    final items = _menuItems(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
                color: const Color(0xFFB71C1C).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(context, items),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 100,
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeOut,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...items],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ParentNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: _handleBottomNavigation,
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, List<Widget> items) {
    return Container(
      width: 240,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB71C1C),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Center(
                    child: Text(
                      'TCP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'EduConnect',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: items,
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red[700],
                minimumSize: const Size.fromHeight(44),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.logout),
              label: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout coming soon')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _menuItems(BuildContext context) {
    Widget tile({
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB71C1C).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: const Color(0xFFB71C1C), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: Colors.grey[500]),
                ],
              ),
            ),
          ),
        ),
      );
    }

    void openPage(Widget page) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    }

    // Parent-relevant features based on the provided menu screenshot.
    return [
      tile(
        icon: Icons.star_rounded,
        label: 'Head of Institute',
        onTap: () => openPage(
          ParentHeadOfInstitutePage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.notifications_rounded,
        label: 'Notices',
        onTap: () => _handleBottomNavigation(2),
      ),
      tile(
        icon: Icons.check_circle_outline_rounded,
        label: 'Attendance',
        onTap: () => _handleBottomNavigation(1),
      ),
      tile(
        icon: Icons.book_rounded,
        label: 'Diary',
        onTap: () => openPage(
          ParentDiaryPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.event_available_rounded,
        label: 'Event & Activities',
        onTap: () => openPage(
          ParentEventsActivitiesPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.payments_rounded,
        label: 'Fee Management',
        onTap: () => openPage(
          ParentFeeManagementPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.fact_check_rounded,
        label: 'Exam Management',
        onTap: () => openPage(
          ParentExamManagementPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.local_library_rounded,
        label: 'Library',
        onTap: () => openPage(
          ParentLibraryPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.menu_book_rounded,
        label: 'Learning Materials',
        onTap: () => openPage(
          ParentLearningMaterialsPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.directions_bus_rounded,
        label: 'Vehicle Management',
        onTap: () => openPage(
          ParentVehicleManagementPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.apartment_rounded,
        label: 'Institute Information',
        onTap: () => openPage(
          ParentInstituteInformationPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.mail_rounded,
        label: 'Invitation / Greetings',
        onTap: () => openPage(
          ParentInvitationsGreetingsPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.newspaper_rounded,
        label: 'Educational News',
        onTap: () => openPage(
          ParentEducationalNewsPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.video_call_rounded,
        label: 'Zoom Class',
        onTap: () => openPage(
          ParentZoomClassPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.school_rounded,
        label: 'e-Learning',
        onTap: () => openPage(
          ParentELearningPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
      tile(
        icon: Icons.more_horiz_rounded,
        label: 'Others',
        onTap: () => openPage(
          ParentOthersPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      ),
    ];
  }

  void _handleBottomNavigation(int index) {
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
