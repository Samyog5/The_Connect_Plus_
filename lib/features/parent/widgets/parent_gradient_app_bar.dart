import 'package:flutter/material.dart';

class ParentGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double toolbarHeight;
  final double elevation;
  final TextStyle? titleTextStyle;

  const ParentGradientAppBar({
    super.key,
    required this.title,
    this.actions,
    this.toolbarHeight = 72,
    this.elevation = 8,
    this.titleTextStyle,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      toolbarHeight: toolbarHeight,
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
      title: Text(
        title,
        style: titleTextStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: actions,
    );
  }
}
