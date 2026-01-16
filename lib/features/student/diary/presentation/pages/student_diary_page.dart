import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/widgets/custom_navbar.dart';
import 'package:go_router/go_router.dart';
import '../bloc/diary_bloc.dart';
import '../bloc/diary_state.dart';
import '../widgets/diary_item_card.dart';
import '../widgets/diary_loading_shimmer.dart';
import '../widgets/diary_empty_state.dart';

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
      body: BlocBuilder<DiaryBloc, DiaryState>(
        builder: (context, state) {
          if (state is DiaryLoading) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Daily Updates'),
                  const SizedBox(height: 20),
                  const DiaryLoadingShimmer(),
                ],
              ),
            );
          }

          if (state is DiaryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
            );
          }

          if (state is DiaryLoaded) {
            final items = state.filteredItems;

            if (items.isEmpty) {
              return const DiaryEmptyState(
                message: 'No diary items available at the moment',
              );
            }

            return SingleChildScrollView(
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildAnimatedSection(
                        index + 1,
                        DiaryItemCard(
                          item: item,
                          onTap: () => context.push(item.route),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
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
}
