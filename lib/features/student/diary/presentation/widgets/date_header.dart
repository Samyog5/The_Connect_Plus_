import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  final DateTime date;
  final String nepaliDate;

  const DateHeader({super.key, required this.date, required this.nepaliDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE, MMM d yyyy').format(date),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        if (nepaliDate.isNotEmpty)
          Text(nepaliDate, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
