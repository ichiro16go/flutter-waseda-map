import 'dart:io';

class Event {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String? place;
  final String? type;
  final String? detail;
  final String storeId;
  final String? twitterPost;
  final String? instagramPost;

  Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.place,
    this.type,
    this.detail,
    required this.storeId,
    this.twitterPost,
    this.instagramPost,
  });
}

class EventPhotos {
  final String id;
  final String eventId;
  final File photoContents;

  EventPhotos({
    required this.id,
    required this.eventId,
    required this.photoContents,
  });
}

class Store {
  final String id;
  final String name;
  final String place;
  final String? description;
  final File? photo;
  final String? instagramId;
  final String? twitterId;

  Store({
    required this.id,
    required this.name,
    required this.place,
    this.description,
    required this.photo,
    this.instagramId,
    this.twitterId,
  });
}

class Customer {
  final String id;
  final String name;
  final String description;
  final String? university;
  final int? grade;
  final String? faculty;
  final File? photo;

  Customer({
    required this.id,
    required this.name,
    required this.description,
    this.university,
    this.grade,
    this.faculty,
    this.photo,
  });
}

class StoreReview {
  final String id;
  final String storeId;
  final String customerId;
  final String? description;
  final int score;
  final DateTime createDate;

  StoreReview({
    required this.id,
    required this.storeId,
    required this.customerId,
    this.description,
    required this.score,
    required this.createDate,
  });
}

class EventReview {
  final String id;
  final String eventId;
  final String customerId;
  final String? description;
  final int score;
  final DateTime createDate;

  EventReview({
    required this.id,
    required this.eventId,
    required this.customerId,
    this.description,
    required this.score,
    required this.createDate,
  });
}
