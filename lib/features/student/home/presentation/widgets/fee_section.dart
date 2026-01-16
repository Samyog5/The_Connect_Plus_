import 'package:flutter/material.dart';
import 'home_section_card.dart';

class FeeSection extends StatelessWidget {
  const FeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeSectionCard(
      title: 'Fee Information',
      accentColor: const Color(0xFFB71C1C),
      actionLabel: 'View Details',
      onAction: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('View fee details')));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB71C1C).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Color(0xFFB71C1C),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Due Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Rs. 4,500.00',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Due: Jan 15, 2026',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.red[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
