import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/injection_container.dart' as di;
import 'package:tcp/features/parent/notices/presentation/bloc/parent_notices_bloc.dart';
import 'package:tcp/features/parent/notices/presentation/bloc/parent_notices_event.dart';
import 'package:tcp/features/parent/notices/presentation/bloc/parent_notices_state.dart';
import 'package:tcp/features/parent/notices/presentation/widgets/parent_notice_card.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';
import 'package:tcp/features/parent/widgets/parent_navbar.dart';

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
  late final ParentNoticesBloc _noticesBloc;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..forward();

    _noticesBloc = di.sl<ParentNoticesBloc>()..add(const LoadParentNotices());
  }

  @override
  void dispose() {
    _animationController.dispose();
    _noticesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _noticesBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: const ParentGradientAppBar(title: 'Notices'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Latest Updates',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                BlocBuilder<ParentNoticesBloc, ParentNoticesState>(
                  builder: (context, state) {
                    if (state is ParentNoticesLoading) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFB71C1C),
                          ),
                        ),
                      );
                    }

                    if (state is ParentNoticesError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }

                    if (state is ParentNoticesLoaded) {
                      return Column(
                        children: state.notices
                            .map((notice) => ParentNoticeCard(notice: notice))
                            .toList(),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ParentNavBar(
          selectedIndex: _selectedNavIndex,
          onTabChanged: _handleNavigation,
        ),
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
