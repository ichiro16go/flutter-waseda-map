import 'package:cloud_firestore/cloud_firestore.dart';
import '../type/type.dart';

class Eventcontroller {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  Future<void> createEvent(Event event) async {
    await _db.collection('events').doc(event.id).set({
      'title': event.title,
      'startDate': event.startDate,
      'endDate': event.endDate,
      'place': event.place,
      'type': event.type,
      'detail': event.detail,
      'storeId': event.storeId,
      'twitterPost': event.twitterPost,
      'instagramPost': event.instagramPost,
    });
  }

  // Read
  Future<Event?> getEvent(String id) async {
    DocumentSnapshot doc = await _db.collection('events').doc(id).get();
    if (doc.exists) {
      return Event(
        id: doc.id,
        title: doc['title'],
        startDate: (doc['startDate'] as Timestamp).toDate(),
        endDate: (doc['endDate'] as Timestamp).toDate(),
        place: doc['place'],
        type: doc['type'],
        detail: doc['detail'],
        storeId: doc['storeId'],
        twitterPost: doc['twitterPost'],
        instagramPost: doc['instagramPost'],
      );
    }
    return null;
  }

  // Update
  Future<void> updateEvent(Event event) async {
    await _db.collection('events').doc(event.id).update({
      'title': event.title,
      'startDate': event.startDate,
      'endDate': event.endDate,
      'place': event.place,
      'type': event.type,
      'detail': event.detail,
      'storeId': event.storeId,
      'twitterPost': event.twitterPost,
      'instagramPost': event.instagramPost,
    });
  }

  // Delete
  Future<void> deleteEvent(String id) async {
    await _db.collection('events').doc(id).delete();
  }
}