import 'package:flutter/material.dart';

class DiaryEntryCard extends StatelessWidget {
  final String subject;
  final String title;
  final String remarks;
  final DateTime? date;
  final bool isGradient;
  final String? status;
  final VoidCallback? onTap;

  const DiaryEntryCard({
    super.key,
    required this.subject,
    required this.title,
    required this.remarks,
    this.date,
    this.isGradient = true, // Default to Homework style
    this.status,
    this.onTap,
  });

  // Helper for gradients
  LinearGradient _getGradient(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
        return const LinearGradient(
          colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
        );
      case 'english':
        return const LinearGradient(
          colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFFA5B4FC), Color(0xFF6366F1)],
        );
    }
  }

  // Helper for subject tag color (Clean style)
  Color _getSubjectColor(String subject) {
    // You can expand this logic or pass colors as props
    return const Color(0xFF4338CA);
  }

  Color _getSubjectBgColor(String subject) {
    return const Color(0xFFE0E7FF);
  }

  @override
  Widget build(BuildContext context) {
    if (isGradient) {
      return _buildGradientCard();
    } else {
      return _buildCleanCard();
    }
  }

  Widget _buildGradientCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: _getGradient(subject),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(title, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  remarks,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCleanCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2E8F0).withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _subjectTag(
                      subject,
                      _getSubjectBgColor(subject),
                      _getSubjectColor(subject),
                    ),
                    if (status != null)
                      Text(
                        status!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  remarks,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_rounded,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Due ${date != null ? date.toString().split(' ')[0] : 'TBD'}",
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    _buildAvatars(),
                  ],
                ),
              ],
            ),
          ),
          if (onTap != null) ...[
            const Divider(height: 1),
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
              ),
              child: const Text(
                "Open Assignment",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4338CA),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _subjectTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAvatars() {
    return SizedBox(
      width: 60,
      height: 25,
      child: Stack(
        children: List.generate(
          3,
          (index) => Positioned(
            left: index * 15,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.blueGrey[100 * (index + 1)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
