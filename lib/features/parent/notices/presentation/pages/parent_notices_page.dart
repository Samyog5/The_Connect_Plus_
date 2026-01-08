import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/features/parent/widgets/parent_navbar.dart';

class ParentNotice {
  final String id;
  final String title;
  final String description;
  final String date;
  final bool isUnread;

  const ParentNotice({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isUnread = false,
  });
}

class ParentNoticesPage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const ParentNoticesPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ParentNoticesPage> createState() => _ParentNoticesPageState();
}

class _ParentNoticesPageState extends State<ParentNoticesPage>
    with TickerProviderStateMixin {
  int _selectedNavIndex = 2;
  late final AnimationController _animationController;
  late final List<ParentNotice> _notices;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..forward();

    _notices = const [
      ParentNotice(
        id: '1',
        title: 'Parent-Teacher Meeting',
        description: 'PTM scheduled for Jan 12, 2026. Please confirm attendance.',
        date: 'Jan 6, 2026',
        isUnread: true,
      ),
      ParentNotice(
        id: '2',
        title: 'Exam Fee Reminder',
        description: 'Exam fee payment window closes on Jan 15, 2026.',
        date: 'Jan 5, 2026',
      ),
      ParentNotice(
        id: '3',
        title: 'Holiday Announcement',
        description: 'School will remain closed on Jan 10, 2026.',
        date: 'Jan 4, 2026',
      ),
    ];
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
          'Notices',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FadeTransition(
          opacity: CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Latest Updates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              ..._notices.map(_buildNoticeCard),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ParentNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: _handleNavigation,
      ),
    );
  }

  Widget _buildNoticeCard(ParentNotice notice) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFB71C1C).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              notice.isUnread ? Icons.mark_email_unread_rounded : Icons.mail_rounded,
              color: const Color(0xFFB71C1C),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notice.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (notice.isUnread)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB71C1C).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          'New',
                          style: TextStyle(
                            color: Color(0xFFB71C1C),
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notice.description,
                  style: TextStyle(color: Colors.grey[700], height: 1.25),
                ),
                const SizedBox(height: 10),
                Text(
                  notice.date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
