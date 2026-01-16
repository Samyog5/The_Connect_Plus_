import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const NewsSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64748B).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
        ),
        decoration: InputDecoration(
          hintText: 'Search academic news...',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey.shade400,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
        ),
      ),
    );
  }
}
