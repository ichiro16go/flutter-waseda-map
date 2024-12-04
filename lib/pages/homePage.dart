import 'package:flutter/material.dart';
import '../type/type.dart';
import '../compornents/timelineChips.dart';
import '../testData/testData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Event> _posts = Testdata().events;
  final List<EventPhotos> photos = Testdata().event_photos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイムライン"),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return Timelinechips(
              event: _posts[index], event_photos: photos[index]);
        },
      ),
    );
  }
}
