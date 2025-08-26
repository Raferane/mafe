import 'package:get/get.dart';
import 'package:unity_project/controllers/home_controller.dart';
import 'package:unity_project/models/events/events_model.dart';

class SearchController extends GetxController {
  SearchController(this._home);

  final HomeController _home;

  final RxString query = ''.obs;

  List<Event> get results {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return const <Event>[];

    bool matches(Event e) {
      final title = (e.title).toLowerCase();
      final location = (e.location).toLowerCase();
      return title.contains(q) || location.contains(q);
    }

    int score(Event e) {
      final title = (e.title).toLowerCase();
      final location = (e.location).toLowerCase();
      if (title.startsWith(q)) return 0;
      if (location.startsWith(q)) return 1;
      if (title.contains(q)) return 2;
      if (location.contains(q)) return 3;
      return 4;
    }

    final filtered = _home.events.where(matches).toList();
    filtered.sort((a, b) {
      final sa = score(a);
      final sb = score(b);
      if (sa != sb) return sa.compareTo(sb);
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });

    return filtered;
  }

  void setQuery(String value) => query.value = value;

  @override
  void onInit() {
    super.onInit();
    debounce<String>(query, (_) {}, time: const Duration(milliseconds: 300));
  }
}
