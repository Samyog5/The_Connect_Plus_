import 'package:flutter/material.dart';

class HomeSectionCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final String actionLabel;
  final VoidCallback onAction;
  final Widget child;

  const HomeSectionCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.actionLabel,
    required this.onAction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
                label: Text(actionLabel),
                style: TextButton.styleFrom(foregroundColor: accentColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
