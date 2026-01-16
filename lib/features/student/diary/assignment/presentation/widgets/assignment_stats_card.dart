import 'package:flutter/material.dart';

class AssignmentStatsCard extends StatelessWidget {
  final double completionPercentage;

  const AssignmentStatsCard({super.key, required this.completionPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4338CA), Color(0xFF6366F1)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Keep it up!",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "${completionPercentage.toStringAsFixed(0)}% Done",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              value: completionPercentage / 100,
              strokeWidth: 8,
              backgroundColor: Colors.white24,
              color: Colors.white,
              strokeCap: StrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }
}
