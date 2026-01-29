
import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/calender/models/event_model.dart';
import 'package:intl/intl.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel event;

  const EventCardWidget({super.key, required this.event});

  String _getDayName(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('EEEE').format(dateTime);
    } catch (e) {
      return 'Unknown';
    }
  }

  Coordinator? _getFirstCoordinator() {
    if (event.course?.coordinator != null && event.course!.coordinator!.isNotEmpty) {
      return event.course!.coordinator!.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final coordinator = _getFirstCoordinator();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBGColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Coordinator Avatar (left)
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            backgroundImage: coordinator?.avatar?.url != null 
                ? NetworkImage(coordinator!.avatar!.url!) 
                : null,
            child: coordinator?.avatar?.url == null 
                ? const Icon(Icons.person, size: 28) 
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course name (title)
                Text(
                  event.course?.name ?? 'No Course',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff090F12),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                
                // Day name (middle)
                Text(
                  _getDayName(event.date),
                  style: const TextStyle(
                    color: Color(0xff1A3E74),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                
                // Coordinator name (last)
                Text(
                  coordinator?.name ?? 'Unknown',
                  style: const TextStyle(
                    color: Color(0xff1A3E74),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

