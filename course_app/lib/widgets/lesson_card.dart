import 'package:flutter/material.dart';
import 'package:course_app/utils/theme.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String duration;
  final bool isPreview;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.title,
    required this.duration,
    required this.isPreview,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(
          Icons.play_circle_outline,
          color: AppTheme.accentColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(duration),
        trailing: isPreview
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withAlpha((0.5 * 255).round()),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Xem thử',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const Icon(Icons.lock_outline),
      ),
    );
  }
}