import 'dart:io';

import 'package:latlong2/latlong.dart';
import '../type/type.dart';

class Testdata {
  List<Event> events = [
  Event(
    id: '1',
    title: 'Sample Event 1',
    startDate: DateTime(2023, 10, 1),
    endDate: DateTime(2023, 10, 2),
    place: LatLng(35.6895, 139.6917), // 東京
    type: 'Conference',
    detail: 'A sample event for testing.',
    storeId: 'store1',
    twitterPost: 'https://twitter.com/sample1',
    instagramPost: 'https://instagram.com/sample1',
  ),
  Event(
    id: '2',
    title: 'Sample Event 2',
    startDate: DateTime(2023, 11, 5),
    endDate: DateTime(2023, 11, 6),
    place: LatLng(34.6937, 135.5023), // 大阪
    type: 'Workshop',
    detail: 'Another sample event for testing.',
    storeId: 'store2',
    twitterPost: 'https://twitter.com/sample2',
    instagramPost: 'https://instagram.com/sample2',
  ),
  Event(
    id: '3',
    title: 'Sample Event 3',
    startDate: DateTime(2023, 12, 1),
    endDate: DateTime(2023, 12, 2),
    place: LatLng(35.0116, 135.7681), // 京都
    type: 'Seminar',
    detail: 'A third sample event for testing.',
    storeId: 'store3',
    twitterPost: 'https://twitter.com/sample3',
    instagramPost: 'https://instagram.com/sample3',
  ),
  Event(
    id: '4',
    title: 'Sample Event 4',
    startDate: DateTime(2024, 1, 10),
    endDate: DateTime(2024, 1, 11),
    place: LatLng(35.6897, 140.0000), // 千葉
    type: 'Exhibition',
    detail: 'A fourth sample event for testing.',
    storeId: 'store4',
    twitterPost: 'https://twitter.com/sample4',
    instagramPost: 'https://instagram.com/sample4',
  ),
  Event(
    id: '5',
    title: 'Sample Event 5',
    startDate: DateTime(2024, 2, 14),
    endDate: DateTime(2024, 2, 15),
    place: LatLng(34.6851, 135.8050), // 奈良
    type: 'Meetup',
    detail: 'A fifth sample event for testing.',
    storeId: 'store5',
    twitterPost: 'https://twitter.com/sample5',
    instagramPost: 'https://instagram.com/sample5',
  ),
  Event(
    id: '6',
    title: 'Sample Event 6',
    startDate: DateTime(2024, 3, 20),
    endDate: DateTime(2024, 3, 21),
    place: LatLng(36.2048, 138.2529), // 長野
    type: 'Festival',
    detail: 'A sixth sample event for testing. aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    storeId: 'store6',
    twitterPost: 'https://twitter.com/sample6',
    instagramPost: 'https://instagram.com/sample6',
  ),
  Event(
    id: '7',
    title: 'Sample Event 7',
    startDate: DateTime(2024, 4, 15),
    endDate: DateTime(2024, 4, 16),
    place: LatLng(34.2250, 135.1675), // 和歌山
    type: 'Competition',
    detail: 'A seventh sample event for testing.',
    storeId: 'store7',
    twitterPost: 'https://twitter.com/sample7',
    instagramPost: 'https://instagram.com/sample7',
  ),
];

List<EventPhotos> event_photos = [
  EventPhotos(
    id: '1',
    eventId: '1',
    photoContents: '../assets/cat_kotatsu_neko.png',
  ),
  EventPhotos(
    id: '2',
    eventId: '2',
    photoContents: '../assets/cat_kotatsu_neko.png',
  ),
  EventPhotos(
    id: '3',
    eventId: '3',
    photoContents: '../assets/cat_kotatsu_neko.png',
  ),
  EventPhotos(
    id: '4',
    eventId: '4',
    photoContents: '../assets/sample_event4.png',
  ),
  EventPhotos(
    id: '5',
    eventId: '5',
    photoContents: '../assets/sample_event5.png',
  ),
  EventPhotos(
    id: '6',
    eventId: '6',
    photoContents: '../assets/sample_event6.png',
  ),
  EventPhotos(
    id: '7',
    eventId: '7',
    photoContents: '../assets/sample_event7.png',
  ),
];

  List<Store> stores = [
    Store(
      id: 'store1',
      name: 'Sample Store 1',
      address: '123 Tokyo St.',
      password: 'password123',
      place: LatLng(35.6895, 139.6917),
      description: 'A sample store for testing.',
      photo: null, 
      instagramId: 'sample_store1',
      twitterId: 'sample_store1',
    ),
    Store(
      id: 'store2',
      name: 'Sample Store 2',
      address: '456 Osaka St.',
      password: 'password456',
      place: LatLng(34.6937, 135.5023),
      description: 'Another sample store for testing.',
      photo: null, 
      instagramId: 'sample_store2',
      twitterId: 'sample_store2',
    ),
  ];

  List<Customer> customers = [
    Customer(
      id: 'customer1',
      name: 'John Doe',
      address: '789 Kyoto St.',
      password: 'customer123',
      description: 'A sample customer for testing.',
      university: 'Kyoto University',
      grade: 3,
      faculty: 'Engineering',
      photo: null, // ダミーデータなのでnullにしています
    ),
    Customer(
      id: 'customer2',
      name: 'Jane Smith',
      address: '101 Nagoya St.',
      password: 'customer456',
      description: 'Another sample customer for testing.',
      university: 'Nagoya University',
      grade: 2,
      faculty: 'Science',
      photo: null, // ダミーデータなのでnullにしています
    ),
  ];

  List<StoreReview> storeReviews = [
    StoreReview(
      id: 'review1',
      storeId: 'store1',
      customerId: 'customer1',
      description: 'Great store!',
      score: 5,
      createDate: DateTime(2023, 10, 10),
    ),
    StoreReview(
      id: 'review2',
      storeId: 'store2',
      customerId: 'customer2',
      description: 'Good service.',
      score: 4,
      createDate: DateTime(2023, 10, 12),
    ),
  ];

  List<EventReview> eventReviews = [
    EventReview(
      id: 'review1',
      eventId: '1',
      customerId: 'customer1',
      description: 'Amazing event!',
      score: 5,
      createDate: DateTime(2023, 10, 11),
    ),
    EventReview(
      id: 'review2',
      eventId: '2',
      customerId: 'customer2',
      description: 'Very informative.',
      score: 4,
      createDate: DateTime(2023, 11, 6),
    ),
  ];
}