import 'package:flutter/material.dart';
import '../../domain/entities/notice.dart';

// Modern color palette with vibrant event-specific colors
const _CATEGORY_COLORS = {
  'Academic': Color(0xFF3B82F6), // Vivid Blue
  'Event': Color(0xFFEC4899), // Pink/Magenta
  'Holiday': Color(0xFFF59E0B), // Amber/Gold
  'Announcement': Color(0xFF8B5CF6), // Purple
};

// Gradient backgrounds for each event type
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

// Background gradients for card badges
final Map<String, Color> _CATEGORY_BG_COLORS = {
  'Academic': const Color(0xFFEFF6FF), // Blue background
  'Event': const Color(0xFFFCE7F3), // Pink background
  'Holiday': const Color(0xFFFEF3C7), // Amber background
  'Announcement': const Color(0xFAF5FF), // Purple background
};

class NoticeCard extends StatelessWidget {
  final Notice notice;
  final VoidCallback onTap;

  const NoticeCard({super.key, required this.notice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final categoryColor =
        _CATEGORY_COLORS[notice.type] ?? const Color(0xFF666666);
    final categoryGradient =
        _CATEGORY_GRADIENTS[notice.type] ??
        const LinearGradient(colors: [Color(0xFF666666), Color(0xFF444444)]);
    final categoryBgColor =
        _CATEGORY_BG_COLORS[notice.type] ?? const Color(0xFFF5F5F5);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: categoryColor.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: categoryColor.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon, title, and unread indicator
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon badge with event-specific gradient
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: categoryGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: categoryColor.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.notifications_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notice.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                                height: 1.3,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          if (notice.isUnread)
                            Container(
                              margin: const EdgeInsets.only(left: 8, top: 2),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: categoryGradient,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: categoryColor.withOpacity(0.4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryBgColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: categoryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          notice.type,
                          style: TextStyle(
                            fontSize: 11,
                            color: categoryColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Description
            Text(
              notice.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            // Divider
            Container(height: 1, color: Colors.grey[150]),
            const SizedBox(height: 14),
            // Metadata and action row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNoticeMetadata(notice),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          categoryColor.withOpacity(0.08),
                          categoryColor.withOpacity(0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: categoryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: categoryColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_right_rounded,
                          color: categoryColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeMetadata(Notice notice) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 12,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                notice.date,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text('•', style: TextStyle(color: Colors.grey[300], fontSize: 14)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_rounded, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                notice.author,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
