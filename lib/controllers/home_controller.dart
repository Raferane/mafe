// lib/controllers/home_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/models/services/event_repository.dart';
import 'package:unity_project/models/services/favorites_repository.dart';
import 'package:unity_project/models/events/events_model.dart';
import 'package:unity_project/models/utility/Components/guest_restrication_dialog.dart';

class HomeController extends GetxController {
  HomeController(
    this._eventRepository,
    this._favoritesRepository,
    this._appService,
  );

  final EventRepository _eventRepository;
  final FavoritesRepository _favoritesRepository;
  final AppService _appService;

  final RxList<Event> events = <Event>[].obs;
  final RxSet<String> favoriteEventIds = <String>{}.obs;
  final RxString searchQuery = ''.obs;

  StreamSubscription<List<Event>>? _eventsSub;
  StreamSubscription<Set<String>>? _favoritesSub;

  @override
  void onInit() {
    super.onInit();
    _eventsSub = _eventRepository.watchApprovedEvents().listen(
      events.assignAll,
    );

    final userId = _appService.user.value?.uid;
    if (userId != null) {
      _favoritesSub = _favoritesRepository
          .favoriteEventIdsStream(userId)
          .listen((ids) {
            favoriteEventIds
              ..clear()
              ..addAll(ids);
          });
    }

    debounce<String>(
      searchQuery,
      (_) {},
      time: const Duration(milliseconds: 300),
    );
  }

  // guest check to toggleFavorite
  Future<void> toggleFavorite(Event event) async {
    if (_appService.isGuestUser()) {
      Get.dialog(
        const GuestRestrictionDialog(
          title: 'Sign In Required',
          message:
              'To save events to your favorites, please sign in to your account.',
        ),
      );
      return;
    }

    final userId = _appService.user.value?.uid;
    if (userId == null) return;

    final isFav = favoriteEventIds.contains(event.id);
    if (isFav) {
      await _favoritesRepository.toggleFavorite(
        userId: userId,
        eventId: event.id,
      );
    } else {
      await _favoritesRepository.toggleFavorite(
        userId: userId,
        eventId: event.id,
      );
    }
  }

  bool isUserParticipating(Event event) {
    final userId = _appService.user.value?.uid;
    if (userId == null) return false;
    return event.participants.contains(userId);
  }

  // guest check to toggleParticipation
  Future<void> toggleParticipation(Event event) async {
    if (_appService.isGuestUser()) {
      Get.dialog(
        const GuestRestrictionDialog(
          title: 'Sign In Required',
          message: 'To join activities  please sign in to your account.',
        ),
      );
      return;
    }

    final userId = _appService.user.value?.uid;
    if (userId == null) return;

    await _eventRepository.toggleParticipation(event.id, userId);
  }

  @override
  void onClose() {
    _eventsSub?.cancel();
    _favoritesSub?.cancel();
    super.onClose();
  }

  List<Event> get visibleEvents {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return events;

    bool matches(Event e) {
      final title = (e.title).toLowerCase();
      final location = (e.location).toLowerCase();
      return title.contains(q) || location.contains(q);
    }

    final filtered = events.where(matches).toList();

    int score(Event e) {
      final title = (e.title).toLowerCase();
      final location = (e.location).toLowerCase();
      if (title.startsWith(q)) return 0;
      if (location.startsWith(q)) return 1;
      if (title.contains(q)) return 2;
      if (location.contains(q)) return 3;
      return 4;
    }

    filtered.sort((a, b) {
      final sa = score(a);
      final sb = score(b);
      if (sa == sb) return sa.compareTo(sb); // stable alphabetical
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    return filtered;
  }

  void setSearchQuery(String value) {
    searchQuery.value = value;
  }
}
