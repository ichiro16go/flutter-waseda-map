import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
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
          ListTile(
            title: const Text('event title'),
            trailing: const Text('date'),
          ),
          ListTile(
            title: const Text('event title'),
            trailing: const Text('date'),
          ),
          ListTile(
            title: const Text('event title'),
            trailing: const Text('date'),
          ),
        ],
      ),
    );
  }
}