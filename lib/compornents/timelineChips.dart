import 'package:flutter/material.dart';
import '../type/type.dart';

class Timelinechips extends StatefulWidget {
  const Timelinechips({
    super.key,
    required this.event,
    required this.event_photos,
  });

  final Event event;
  final EventPhotos event_photos;

  @override
  _TimelinechipsState createState() => _TimelinechipsState();
}

class _TimelinechipsState extends State<Timelinechips> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                  ),
                  child: Text(
                    widget.event.detail ?? 'detail...',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.grey,
            child: Center(
              child: widget.event_photos.photoContents != null
                  ? Image.asset(widget.event_photos.photoContents!)
                  : const FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(
                        Icons.image_not_supported,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
