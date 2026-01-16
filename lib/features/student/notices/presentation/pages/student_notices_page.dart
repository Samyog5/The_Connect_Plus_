import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp/features/student/widgets/custom_navbar.dart';
import 'package:tcp/injection_container.dart' as di;
import '../bloc/notices_bloc.dart';
import '../bloc/notices_event.dart';
import '../bloc/notices_state.dart';
import '../widgets/notice_card.dart';
import '../widgets/notice_filter_chips.dart';
import '../widgets/notice_empty_state.dart';

const _BACKGROUND_GRADIENT = LinearGradient(
  colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

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
    return BlocProvider(
      create: (context) => di.sl<NoticesBloc>()..add(LoadNotices()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(gradient: _BACKGROUND_GRADIENT),
          child: BlocBuilder<NoticesBloc, NoticesState>(
            builder: (context, state) {
              if (state is NoticesLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is NoticesError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is NoticesLoaded) {
                final filteredNotices = state.filteredNotices;

                return filteredNotices.isEmpty
                    ? NoticeEmptyState(
                        onViewAll: () {
                          context.read<NoticesBloc>().add(
                            const FilterNoticesByCategory('All'),
                          );
                        },
                      )
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
                            _buildFilterChips(context, state.selectedCategory),
                            const SizedBox(height: 28),
                            ..._buildAnimatedNoticeCards(
                              context,
                              filteredNotices,
                            ),
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

            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/diary');
                break;
              case 2:
                // Already on notices
                break;
              case 3:
                context.go('/more');
                break;
            }
          },
          isBottomNav: true,
        ),
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

  Widget _buildFilterChips(BuildContext context, String selectedCategory) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
            ),
          ),
      child: NoticeFilterChips(
        selectedCategory: selectedCategory,
        onCategorySelected: (category) {
          context.read<NoticesBloc>().add(FilterNoticesByCategory(category));
        },
      ),
    );
  }

  List<Widget> _buildAnimatedNoticeCards(BuildContext context, List notices) {
    return List.generate(notices.length, (index) {
      final notice = notices[index];
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
          child: NoticeCard(
            notice: notice,
            onTap: () {
              context.read<NoticesBloc>().add(MarkNoticeAsRead(notice.id));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green[300],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Opened: ${notice.title}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFF0F172A),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
