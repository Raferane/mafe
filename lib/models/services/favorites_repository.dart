import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesRepository {
  FavoritesRepository([FirebaseFirestore? firestore])
    : _db = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _db;

  Stream<Set<String>> favoriteEventIdsStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.id).toSet());
  }

  Future<void> toggleFavorite({
    required String userId,
    required String eventId,
  }) async {
    final ref = _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(eventId);

    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'createdAt': FieldValue.serverTimestamp()});
    }
  }
}
