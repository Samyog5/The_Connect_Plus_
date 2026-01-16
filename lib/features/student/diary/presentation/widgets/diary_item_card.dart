import 'package:flutter/material.dart';
import '../../domain/entities/diary_item.dart';

class DiaryItemCard extends StatelessWidget {
  final DiaryItem item;
  final VoidCallback onTap;

  const DiaryItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.count,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: item.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
