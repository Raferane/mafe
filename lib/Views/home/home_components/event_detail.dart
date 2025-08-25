import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/home_controller.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/models/utility/Components/guest_restrication_dialog.dart';

class EventDetail extends StatelessWidget {
  EventDetail({super.key});
  final appService = Get.find<AppService>();

  // Handle favorite with guest check
  void _handleFavoriteToggle(Event event, HomeController controller) {
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

    controller.toggleFavorite(event);
  }

  // Handle participation with guest check
  void _handleParticipationToggle(Event event, HomeController controller) {
    if (appService.isGuestUser()) {
      Get.dialog(
        const GuestRestrictionDialog(
          title: 'Sign In Required',
          message: 'To join activities, please sign in to your account.',
        ),
      );
      return;
    }

    controller.toggleParticipation(event);
  }

  @override
  Widget build(BuildContext context) {
    final Event event = Get.arguments as Event;
    final controller = Get.find<HomeController>();
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xffedf2f4),
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Animation
          SliverAppBar(
            expandedHeight: height * 0.25,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xff545454),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff545454), Color(0xff545454)],
                  ),
                ),
                child: Stack(
                  children: [
                    // Hero animated date badge
                    Positioned(
                      left: 20,
                      top: 80,
                      child: Hero(
                        tag: 'date_${event.id}_$hashCode',
                        child: _DateBadge(date: event.dateTime),
                      ),
                    ),
                    // Event title overlay
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  event.location,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Event Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date and Time Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: const Color(0xff545454),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatDate(event.dateTime),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff545454),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTime(event.dateTime),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Location Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: const Color(0xff545454),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            event.location,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff545454),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About This Event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff545454),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          event.description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Replace the participants section with:
                  Obx(() {
                    final currentEvent =
                        controller.events.firstWhereOrNull(
                          (e) => e.id == event.id,
                        ) ??
                        event;
                    final isParticipating = controller.isUserParticipating(
                      currentEvent,
                    );

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people,
                              color: const Color(0xff545454),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${currentEvent.participants.length} Participants',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff545454),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isParticipating
                                        ? 'You are participating'
                                        : 'Join this event',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Obx(() {
                    final currentEvent =
                        controller.events.firstWhereOrNull(
                          (e) => e.id == event.id,
                        ) ??
                        event;
                    final isParticipating = controller.isUserParticipating(
                      currentEvent,
                    );
                    final isFavorite = controller.favoriteEventIds.contains(
                      event.id,
                    );

                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _handleParticipationToggle(
                                currentEvent,
                                controller,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isParticipating
                                      ? Colors.red
                                      : const Color(0xff545454),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              isParticipating
                                  ? 'Cancel Participation'
                                  : 'Join Event',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff545454)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _handleFavoriteToggle(event, controller);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorite ? Colors.red : Color(0xff545454),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour}:${minute.toString().padLeft(2, '0')} $period';
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(240),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
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
              fontSize: 20,
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
    );
  }
}
