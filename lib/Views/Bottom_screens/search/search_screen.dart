import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unity_project/controllers/search_controller.dart';
import 'package:unity_project/controllers/home_controller.dart';
import 'package:unity_project/Views/home/home_components/event_card.dart';
import 'package:unity_project/models/events/events_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _text = TextEditingController();
  late final SearchController search;
  late final HomeController home;

  @override
  void initState() {
    super.initState();
    search = Get.find<SearchController>();
    home = Get.find<HomeController>();
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          children: [
            TextField(
              controller: _text,
              textInputAction: TextInputAction.search,
              onTapOutside:
                  (event) =>
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus(),
              onSubmitted:
                  (_) =>
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus(),
              onChanged: search.setQuery,
              decoration: InputDecoration(
                hintText: 'Search events by name...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff545454).withAlpha(100),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff545454).withAlpha(100),
                  fontSize: height * 0.018,
                ),
                suffixIcon: Obx(() {
                  final hasText = search.query.value.trim().isNotEmpty;
                  if (!hasText) return const SizedBox.shrink();
                  return IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _text.clear();
                      search.setQuery('');
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                    },
                  );
                }),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Color(0xff545454).withAlpha(100),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Color(0xff545454)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                final q = search.query.value.trim();
                final List<Event> items = search.results;

                if (q.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/searchingForResults.json',
                          width: width * 0.5,
                          height: height * 0.2,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          'Search for events.',
                          style: TextStyle(
                            color: Color(0xff545454).withAlpha(100),
                            fontSize: height * 0.018,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/noResult.json',
                          width: width * 0.5,
                          height: height * 0.2,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          'No matches for "$q".',
                          style: TextStyle(
                            color: Color(0xff545454).withAlpha(100),
                            fontSize: height * 0.018,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final e = items[i];
                    final isFav = home.favoriteEventIds.contains(e.id);
                    return Padding(
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      child: EventCard(
                        event: e,
                        isFavorite: isFav,
                        onFavoriteToggle: () => home.toggleFavorite(e),
                        onTap: () {
                          // optional: navigate to details
                        },
                        heroTag: 'search_event_${e.id}_$i',
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
