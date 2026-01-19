import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/injection_container.dart' as di;
import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_destination.dart';
import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_item.dart';
import 'package:tcp/features/parent/more/presentation/bloc/parent_more_bloc.dart';
import 'package:tcp/features/parent/more/presentation/bloc/parent_more_event.dart';
import 'package:tcp/features/parent/more/presentation/bloc/parent_more_state.dart';
import 'package:tcp/features/parent/diary/presentation/pages/parent_diary_page.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';
import 'package:tcp/features/parent/widgets/parent_menu_tile.dart';
import 'package:tcp/features/parent/widgets/parent_navbar.dart';

import 'package:tcp/features/parent/more/presentation/pages/parent_educational_news_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_elearning_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_events_activities_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_exam_management_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_fee_management_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_head_of_institute_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_institute_information_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_invitations_greetings_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_learning_materials_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_library_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_others_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_vehicle_management_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_zoom_class_page.dart';

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
  late final ParentMoreBloc _moreBloc;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..forward();

    _moreBloc = di.sl<ParentMoreBloc>()..add(const LoadParentMoreMenu());
  }

  @override
  void dispose() {
    _animationController.dispose();
    _moreBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return BlocProvider.value(
      value: _moreBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: const ParentGradientAppBar(title: 'More'),
        body: BlocBuilder<ParentMoreBloc, ParentMoreState>(
          builder: (context, state) {
            if (state is ParentMoreLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFB71C1C)),
              );
            }

            if (state is ParentMoreError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final items = state is ParentMoreLoaded ? state.items : const <ParentMoreMenuItem>[];
            final tiles = items
                .map(
                  (item) => ParentMenuTile(
                    icon: _iconForDestination(item.destination),
                    label: item.label,
                    onTap: () => _handleMenuTap(item.destination),
                  ),
                )
                .toList(growable: false);

            return Row(
              children: [
                if (!isMobile) _buildSidebar(context, tiles),
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
                        children: tiles,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: ParentNavBar(
          selectedIndex: _selectedNavIndex,
          onTabChanged: _handleBottomNavigation,
        ),
      ),
    );
  }

  IconData _iconForDestination(ParentMoreMenuDestination destination) {
    switch (destination) {
      case ParentMoreMenuDestination.headOfInstitute:
        return Icons.star_rounded;
      case ParentMoreMenuDestination.noticesTab:
        return Icons.notifications_rounded;
      case ParentMoreMenuDestination.attendanceTab:
        return Icons.check_circle_outline_rounded;
      case ParentMoreMenuDestination.diary:
        return Icons.book_rounded;
      case ParentMoreMenuDestination.eventsActivities:
        return Icons.event_available_rounded;
      case ParentMoreMenuDestination.feeManagement:
        return Icons.payments_rounded;
      case ParentMoreMenuDestination.examManagement:
        return Icons.fact_check_rounded;
      case ParentMoreMenuDestination.library:
        return Icons.local_library_rounded;
      case ParentMoreMenuDestination.learningMaterials:
        return Icons.menu_book_rounded;
      case ParentMoreMenuDestination.vehicleManagement:
        return Icons.directions_bus_rounded;
      case ParentMoreMenuDestination.instituteInformation:
        return Icons.apartment_rounded;
      case ParentMoreMenuDestination.invitationsGreetings:
        return Icons.mail_rounded;
      case ParentMoreMenuDestination.educationalNews:
        return Icons.newspaper_rounded;
      case ParentMoreMenuDestination.zoomClass:
        return Icons.video_call_rounded;
      case ParentMoreMenuDestination.eLearning:
        return Icons.school_rounded;
      case ParentMoreMenuDestination.others:
        return Icons.more_horiz_rounded;
    }
  }

  void _handleMenuTap(ParentMoreMenuDestination destination) {
    void openPage(Widget page) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    }

    switch (destination) {
      case ParentMoreMenuDestination.noticesTab:
        _handleBottomNavigation(2);
        return;
      case ParentMoreMenuDestination.attendanceTab:
        _handleBottomNavigation(1);
        return;
      case ParentMoreMenuDestination.diary:
        openPage(
          ParentDiaryPage(userName: widget.userName, userAvatar: widget.userAvatar),
        );
        return;
      case ParentMoreMenuDestination.headOfInstitute:
        openPage(
          ParentHeadOfInstitutePage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.eventsActivities:
        openPage(
          ParentEventsActivitiesPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.feeManagement:
        openPage(
          ParentFeeManagementPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.examManagement:
        openPage(
          ParentExamManagementPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.library:
        openPage(
          ParentLibraryPage(userName: widget.userName, userAvatar: widget.userAvatar),
        );
        return;
      case ParentMoreMenuDestination.learningMaterials:
        openPage(
          ParentLearningMaterialsPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.vehicleManagement:
        openPage(
          ParentVehicleManagementPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.instituteInformation:
        openPage(
          ParentInstituteInformationPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.invitationsGreetings:
        openPage(
          ParentInvitationsGreetingsPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.educationalNews:
        openPage(
          ParentEducationalNewsPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        );
        return;
      case ParentMoreMenuDestination.zoomClass:
        openPage(
          ParentZoomClassPage(userName: widget.userName, userAvatar: widget.userAvatar),
        );
        return;
      case ParentMoreMenuDestination.eLearning:
        openPage(
          ParentELearningPage(userName: widget.userName, userAvatar: widget.userAvatar),
        );
        return;
      case ParentMoreMenuDestination.others:
        openPage(
          ParentOthersPage(userName: widget.userName, userAvatar: widget.userAvatar),
        );
        return;
    }
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
