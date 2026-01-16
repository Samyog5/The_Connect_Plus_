import 'package:flutter/material.dart';

// Modern color palette with vibrant event-specific colors
const _CATEGORY_COLORS = {
  'Academic': Color(0xFF3B82F6),
  'Event': Color(0xFFEC4899),
  'Holiday': Color(0xFFF59E0B),
  'Announcement': Color(0xFF8B5CF6),
};

final Map<String, LinearGradient> _CATEGORY_GRADIENTS = {
  'Academic': const LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  'Event': const LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xBE185D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  'Holiday': const LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  'Announcement': const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
};

class NoticeFilterChips extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const NoticeFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Academic', 'Event', 'Holiday', 'Announcement'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          final categoryColor = category == 'All'
              ? const Color(0xFF0F172A)
              : _CATEGORY_COLORS[category] ?? const Color(0xFF666666);
          final categoryGradient = category == 'All'
              ? const LinearGradient(
                  colors: [Color(0xFF1F2937), Color(0xFF0F172A)],
                )
              : _CATEGORY_GRADIENTS[category];

          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? categoryGradient : null,
                color: isSelected ? null : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey[300]!,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: categoryColor.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: InkWell(
                onTap: () => onCategorySelected(category),
                borderRadius: BorderRadius.circular(24),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.grey[700],
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
