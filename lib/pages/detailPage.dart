import 'package:flutter/material.dart';
import '../type/type.dart';
import '../compornents/timelineChips.dart';
import '../testData/testData.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Event> _posts = Testdata().events;
  final List<EventPhotos> photos = Testdata().event_photos;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: Text('photo')),
          ),
          const SizedBox(height: 16),
          const Text('title', style: TextStyle(fontSize: 24)),
          const Text('description'),
          const Text('site'),
          const SizedBox(height: 16),
          const Text('timeline', style: TextStyle(fontSize: 18)),
          Expanded(
            child:ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Timelinechips(
                    event: _posts[index], event_photos: photos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
