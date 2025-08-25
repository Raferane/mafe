import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unity_project/controllers/home_controller.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/Views/home/home_components/event_card.dart';

class UpcomingEventsSection extends StatelessWidget {
  final HomeController controller;
  final VoidCallback onSeeAll;

  const UpcomingEventsSection({
    super.key,
    required this.controller,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(onPressed: onSeeAll, child: const Text('See all')),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: StreamBuilder<List<Event>>(
            stream: controller.events.stream,
            builder: (context, eventsSnap) {
              if (eventsSnap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (eventsSnap.hasError) {
                return const Center(child: Text('Failed to load events'));
              }
              final events = eventsSnap.data ?? [];
              if (events.isEmpty) {
                return const Center(child: Text('No upcoming events'));
              }

              final favoritesStream =
                  uid != null
                      ? controller.favoriteEventIds.stream
                      : Stream.value(<String>{});

              return StreamBuilder<Set<String>>(
                stream: favoritesStream,
                builder: (context, favSnap) {
                  final favoriteIds = favSnap.data ?? <String>{};
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: events.length,
                    itemBuilder: (_, i) {
                      final e = events[i];
                      final isFav = favoriteIds.contains(e.id);
                      return EventCard(
                        event: e,
                        isFavorite: isFav,
                        onTap: () {
                          // Hook to details screen (optional later)
                        },
                        onFavoriteToggle: () {
                          controller.toggleFavorite(e);
                        },
                        heroTag: 'event_card_${e.id}_$i',
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
