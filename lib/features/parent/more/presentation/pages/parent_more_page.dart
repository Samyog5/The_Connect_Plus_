import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tcp/features/parent/more/presentation/menu/parent_more_menu_items.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';
import 'package:tcp/features/parent/widgets/parent_menu_tile.dart';
import 'package:tcp/features/parent/widgets/parent_navbar.dart';

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

    final menuItems = buildParentMoreMenuItems(
      context: context,
      userName: widget.userName,
      userAvatar: widget.userAvatar,
      onBottomNavTap: _handleBottomNavigation,
    );

    final tiles = menuItems
        .map(
          (item) => ParentMenuTile(
            icon: item.icon,
            label: item.label,
            onTap: () => item.onTap(context),
          ),
        )
        .toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const ParentGradientAppBar(title: 'More'),
      body: Row(
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
