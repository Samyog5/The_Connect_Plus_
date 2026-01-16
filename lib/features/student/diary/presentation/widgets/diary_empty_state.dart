import 'package:flutter/material.dart';

class DiaryEmptyState extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const DiaryEmptyState({
    super.key,
    this.message = 'No diary items available',
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
