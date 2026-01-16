import 'package:flutter/material.dart';

class DiaryFilterChips extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const DiaryFilterChips({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final types = [
      {'label': 'All', 'value': 'all'},
      {'label': 'Academic', 'value': 'academic'},
      {'label': 'Schedule', 'value': 'schedule'},
      {'label': 'Administrative', 'value': 'administrative'},
      {'label': 'Events', 'value': 'events'},
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = selectedType == type['value'];

          return FilterChip(
            label: Text(type['label']!),
            selected: isSelected,
            onSelected: (_) => onTypeSelected(type['value']!),
            backgroundColor: Colors.white,
            selectedColor: const Color(0xFFB71C1C).withOpacity(0.1),
            checkmarkColor: const Color(0xFFB71C1C),
            labelStyle: TextStyle(
              color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
            side: BorderSide(
              color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[300]!,
              width: 1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          );
        },
      ),
    );
  }
}
