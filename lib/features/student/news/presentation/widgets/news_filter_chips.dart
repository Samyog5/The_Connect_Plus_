import 'package:flutter/material.dart';

class NewsFilterChips extends StatelessWidget {
  final List<String> categories;
  final String activeCategory;
  final Function(String) onCategorySelected;

  const NewsFilterChips({
    super.key,
    required this.categories,
    required this.activeCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: categories.map((cat) {
          final isActive = activeCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => onCategorySelected(cat),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFEF4444) // Red 500
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(0xFFEF4444).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: isActive ? Colors.white : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
