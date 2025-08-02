import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime dateTime;
  final String createdBy;
  final List<String> participants;
  final bool isActive;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.createdBy,
    required this.participants,
    this.isActive = true,
  });

  // Factory constructor to create Event from Firestore
  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      createdBy: data['createdBy'] ?? '',
      participants: List<String>.from(data['participants'] ?? []),
      isActive: data['isActive'] ?? true,
    );
  }

  // Convert Event to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'dateTime': dateTime,
      'createdBy': createdBy,
      'participants': participants,
      'isActive': isActive,
    };
  }
}
