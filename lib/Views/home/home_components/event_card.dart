import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/models/utility/Components/guest_restrication_dialog.dart';
import 'package:unity_project/routes/app_routes.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.isFavorite,
    required this.onFavoriteToggle,
    this.onTap,
    required String heroTag,
  });

  final Event event;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback? onTap;

  void _handleFavoriteToggle() {
    final appService = Get.find<AppService>();

    if (appService.isGuestUser()) {
      Get.dialog(
        const GuestRestrictionDialog(
          title: 'Sign In Required',
          message:
              'To save events to your favorites, please sign in to your account.',
        ),
      );
      return;
    }

    onFavoriteToggle();
  }

  @override
  Widget build(BuildContext context) {
    final String title = event.title;
    final String location = event.location;
    final String description = event.description;
    final DateTime dateTime = event.dateTime;

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.eventDetail, arguments: event);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE9ECEF)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header strip with gradient and floating controls
            Container(
              height: 96,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff545454).withAlpha(200),
                    const Color(0xff545454).withAlpha(120),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Hero(
                      tag: 'date_${event.id}_$hashCode',
                      child: _DateBadge(date: dateTime),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: _FavoritePill(
                      isFav: isFavorite,
                      onTap: _handleFavoriteToggle,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff545454),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.place, size: 16, color: Colors.grey[700]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  if (description.trim().isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700], height: 1.3),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date});

  final DateTime date;

  String get _monthAbbr {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[date.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = _monthAbbr;

    return Semantics(
      label: 'Event date $day $month',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(240),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xff545454),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              month,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritePill extends StatelessWidget {
  const _FavoritePill({required this.isFav, required this.onTap});

  final bool isFav;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isFav ? 'Remove from favorites' : 'Add to favorites',
      child: Material(
        color: Colors.white.withAlpha(240),
        shape: const StadiumBorder(),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                  color: isFav ? Colors.pink : const Color(0xff545454),
                ),
                const SizedBox(width: 6),
                Text(
                  isFav ? 'Saved' : 'Save',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isFav ? Colors.pink : const Color(0xff545454),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
