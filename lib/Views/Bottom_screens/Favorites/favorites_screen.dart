import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unity_project/controllers/home_controller.dart';
import 'package:unity_project/Views/home/home_components/event_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final favIds = controller.favoriteEventIds;
      final favEvents =
          controller.events.where((e) => favIds.contains(e.id)).toList();

      if (favEvents.isEmpty) {
        return const Center(child: Text('No favorites yet.'));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: favEvents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final e = favEvents[i];
          return EventCard(
            event: e,
            isFavorite: true,
            onFavoriteToggle: () => controller.toggleFavorite(e),
            heroTag: 'event_card_${e.id}_$i',
          );
        },
      );
    });
  }
}
