import 'package:flutter/material.dart';
import '../type/type.dart';
import '../testData/testData.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({
    super.key,
    required this.event,
    required this.event_photos,
  });

  final Event event;
  final EventPhotos event_photos;

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // コンテンツ部分
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Text(widget.event.title)),
                ),
              ],
            ),
          ),
          // 左上に戻るボタン
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back, // 左矢印アイコン
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
