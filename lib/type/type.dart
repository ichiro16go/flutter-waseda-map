import 'dart:io';

import 'package:latlong2/latlong.dart';

class Event {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final LatLng? place;
  final String? type;
  final String? detail;
  final String storeId;
  final String? twitter;
  final String? instagram;

  Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.place,
    this.type,
    this.detail,
    required this.storeId,
    this.twitter,
    this.instagram,
  });
}

class EventPhotos {
  final String id;
  final String eventId;
  final String? photoContents;

  EventPhotos({
    required this.id,
    required this.eventId,
    this.photoContents,
  });
}

class Store {
  final String id;
  final String name;
  final String address;
  final String password;
  final LatLng place;
  final String? description;
  final String? photo;
  final String? instagramId;
  final String? twitterId;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.password,
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
  final String address;
  final String password;
  final String description;
  final String? university;
  final int? grade;
  final String? faculty;
  final String? photo;

  Customer({
    required this.id,
    required this.name,
    required this.address,
    required this.password,
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
