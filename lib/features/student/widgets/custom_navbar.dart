import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final bool isBottomNav;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    this.isBottomNav = true,
    required void Function(int index) onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isBottomNav) return _buildBottomNavBar(context);
    return _buildTopNavBar(context);
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
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
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: const Color(0xFFB71C1C),
      unselectedItemColor: Colors.grey[500],
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_rounded),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_rounded),
          label: 'Notices',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_rounded),
          label: 'More',
        ),
      ],
    );
  }

  Widget _buildTopNavBar(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.home_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () => context.go('/schedule'),
            icon: const Icon(Icons.calendar_today_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () => context.go('/notices'),
            icon: const Icon(Icons.notifications_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () => context.go('/more'),
            icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
