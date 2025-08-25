import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unity_project/models/events/events_model.dart';

class EventRepository {
  EventRepository([FirebaseFirestore? firestore])
    : _db = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _db;

  Stream<List<Event>> WatchApprovedEvents() {
    return _db
        .collection('events')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Event.fromFirestore(d)).toList());
  }

  Future<void> toggleParticipation(String eventId, String userId) async {
    final eventRef = _db.collection('events').doc(eventId);

    await _db.runTransaction((transaction) async {
      final eventDoc = await transaction.get(eventRef);
      final participants = List<String>.from(
        eventDoc.data()?['participants'] ?? [],
      );

      if (participants.contains(userId)) {
        // User is already participating, remove them
        participants.remove(userId);
      } else {
        // User is not participating, add them
        participants.add(userId);
      }

      transaction.update(eventRef, {'participants': participants});
    });
  }
}
