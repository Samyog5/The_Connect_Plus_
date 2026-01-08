import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:tcp/features/student/widgets/custom_navbar.dart';
import '../../../home/presentation/pages/student_home_page.dart';
import '../../../schedule/presentation/pages/student_schedule_page.dart';

import '../../../more/presentation/pages/student_more_page.dart';

// Modern color palette with vibrant event-specific colors
const _CATEGORY_COLORS = {
  'Academic': Color(0xFF3B82F6), // Vivid Blue
  'Event': Color(0xFFEC4899), // Pink/Magenta
  'Holiday': Color(0xFFF59E0B), // Amber/Gold
  'Announcement': Color(0xFF8B5CF6), // Purple
};

// Gradient backgrounds for each event type
final Map<String, LinearGradient> _CATEGORY_GRADIENTS = {
  'Academic': const LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  'Event': const LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xBE185D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  'Holiday': const LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  'Announcement': const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
};

// Background gradients for card badges
final Map<String, Color> _CATEGORY_BG_COLORS = {
  'Academic': const Color(0xFFEFF6FF), // Blue background
  'Event': const Color(0xFFFCE7F3), // Pink background
  'Holiday': const Color(0xFFFEF3C7), // Amber background
  'Announcement': const Color(0xFAF5FF), // Purple background
};

const _BACKGROUND_GRADIENT = LinearGradient(
  colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class Notice {
  final String id;
  final String type;
  final String title;
  final String description;
  final String date;
  final String author;
  final String priority;
  final bool isUnread;

  Notice({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    required this.author,
    required this.priority,
    this.isUnread = false,
  });
}

class StudentNoticesPage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const StudentNoticesPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<StudentNoticesPage> createState() => _StudentNoticesPageState();
}

class _StudentNoticesPageState extends State<StudentNoticesPage>
    with TickerProviderStateMixin {
  int _selectedNavIndex = 2;
  String _selectedCategory = 'All';
  late AnimationController _animationController;
  late List<Notice> notices;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    notices = [
      Notice(
        id: '1',
        type: 'Academic',
        title: 'Final Exam Schedule Released',
        description:
            'The final examination schedule has been released. Classes will end on March 10, 2026.',
        date: 'Jan 5, 2026',
        author: 'Academic Department',
        priority: 'High',
        isUnread: true,
      ),
      Notice(
        id: '2',
        type: 'Event',
        title: 'Sports Day Next Month',
        description:
            'Annual sports day will be held on February 15, 2026. All students are encouraged to participate.',
        date: 'Jan 3, 2026',
        author: 'Sports Committee',
        priority: 'Medium',
        isUnread: false,
      ),
      Notice(
        id: '3',
        type: 'Holiday',
        title: 'Republic Day Holiday',
        description:
            'School will remain closed on January 26, 2026 for Republic Day celebration.',
        date: 'Jan 1, 2026',
        author: 'Administration',
        priority: 'Normal',
        isUnread: false,
      ),
      Notice(
        id: '4',
        type: 'Academic',
        title: 'Winter Vacation Extended',
        description:
            'Due to weather conditions, winter vacation has been extended by 2 days.',
        date: 'Dec 28, 2025',
        author: 'Academic Department',
        priority: 'Medium',
        isUnread: false,
      ),
    ];

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Notice> get _filteredNotices {
    if (_selectedCategory == 'All') {
      return notices;
    }
    return notices.where((n) => n.type == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: _BACKGROUND_GRADIENT),
        child: _filteredNotices.isEmpty
            ? _buildEmptyState()
            : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 60,
                  bottom: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(),
                    const SizedBox(height: 32),
                    _buildFilterChips(),
                    const SizedBox(height: 28),
                    ..._buildAnimatedNoticeCards(),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentHomePage(
                  userName: widget.userName,
                  userRole: 'Student',
                  userAvatar: widget.userAvatar,
                  className: 'Class 10 - A',
                ),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentSchedulePage(
                  userName: widget.userName,
                  userAvatar: widget.userAvatar,
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentNoticesPage(
                  userName: widget.userName,
                  userAvatar: widget.userAvatar,
                ),
              ),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentMorePage(
                  userName: widget.userName,
                  userAvatar: widget.userAvatar,
                ),
              ),
            );
          }
        },
        isBottomNav: true,
      ),
    );
  }

  Widget _buildPageHeader() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0, 0.3, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0, 0.3, curve: Curves.easeOut),
              ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDC2626), Color(0xFFB91C1C)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Notices',
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
              'Stay informed with latest announcements',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final categories = ['All', 'Academic', 'Event', 'Holiday', 'Announcement'];

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
            ),
          ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categories.length, (index) {
            final category = categories[index];
            final isSelected = _selectedCategory == category;
            final categoryColor = category == 'All'
                ? const Color(0xFF0F172A)
                : _CATEGORY_COLORS[category] ?? const Color(0xFF666666);
            final categoryGradient = category == 'All'
                ? const LinearGradient(
                    colors: [Color(0xFF1F2937), Color(0xFF0F172A)],
                  )
                : _CATEGORY_GRADIENTS[category];

            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected ? categoryGradient : null,
                  color: isSelected
                      ? null
                      : Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey[300]!,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: categoryColor.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  borderRadius: BorderRadius.circular(24),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : Colors.grey[700],
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedNoticeCards() {
    return List.generate(_filteredNotices.length, (index) {
      final notice = _filteredNotices[index];
      final delay = index * 0.08;

      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.25 + delay, 1.0, curve: Curves.easeOut),
              ),
            ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Interval(0.25 + delay, 1.0, curve: Curves.easeOut),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildNoticeCard(notice),
          ),
        ),
      );
    });
  }

  Widget _buildNoticeCard(Notice notice) {
    final categoryColor =
        _CATEGORY_COLORS[notice.type] ?? const Color(0xFF666666);
    final categoryGradient =
        _CATEGORY_GRADIENTS[notice.type] ??
        const LinearGradient(colors: [Color(0xFF666666), Color(0xFF444444)]);
    final categoryBgColor =
        _CATEGORY_BG_COLORS[notice.type] ?? const Color(0xFFF5F5F5);

    return StatefulBuilder(
      builder: (context, setCardState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              _handleNoticeClick(notice);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: categoryColor.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: categoryColor.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with icon, title, and unread indicator
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon badge with event-specific gradient
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: categoryGradient,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: categoryColor.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.notifications_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notice.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0F172A),
                                      height: 1.3,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                                if (notice.isUnread)
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 8,
                                      top: 2,
                                    ),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      gradient: categoryGradient,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: categoryColor.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: categoryBgColor,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: categoryColor.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Text(
                                notice.type,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: categoryColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Description
                  Text(
                    notice.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Divider
                  Container(height: 1, color: Colors.grey[150]),
                  const SizedBox(height: 14),
                  // Metadata and action row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNoticeMetadata(notice),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                categoryColor.withValues(alpha: 0.08),
                                categoryColor.withValues(alpha: 0.04),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: categoryColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: categoryColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_right_rounded,
                                color: categoryColor,
                                size: 16,
                              ),
                            ],
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
      },
    );
  }

  Widget _buildNoticeMetadata(Notice notice) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 12,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                notice.date,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text('•', style: TextStyle(color: Colors.grey[300], fontSize: 14)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_rounded, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                notice.author,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.elasticOut,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[300]!, Colors.grey[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No Notices Yet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[800],
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nothing to show in this category',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'All';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inbox_rounded, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'View All Notices',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
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

  void _handleNoticeClick(Notice notice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.green[300],
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Opened: ${notice.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
