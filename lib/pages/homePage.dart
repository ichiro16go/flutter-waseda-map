import 'package:flutter/material.dart';
import '../type/type.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Event> _posts = [
    Event(
      id: '1',
      title: 'イベント1',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 1)),
      place: '東京',
      type: '音楽',
      detail: '音楽イベントの詳細',
      storeId: 'store1',
      twitterPost: 'https://twitter.com/event1',
      instagramPost: 'https://instagram.com/event1',
    ),
    Event(
      id: '2',
      title: 'イベント2',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 2)),
      place: '大阪',
      type: 'アート',
      detail: 'アートイベントの詳細',
      storeId: 'store2',
      twitterPost: 'https://twitter.com/event2',
      instagramPost: 'https://instagram.com/event2',
    ),
    // 他のダミーデータを追加
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイムライン"),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(_posts[index].title),
              subtitle: Text(_posts[index].detail ?? ''),
            ),
          );
        },
      ),
    );
  }
}