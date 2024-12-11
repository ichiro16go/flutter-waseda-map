import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<List<Map<String, dynamic>>> fetchNearbyData(Position position) async {
  final latitude = position.latitude;
  final longitude = position.longitude;

  final url =
      'http://overpass-api.de/api/interpreter?data=[out:json];node(around:200,$latitude,$longitude);out;';
  
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final elements = data['elements'] as List;
    return elements.map((e) => e as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to fetch data from OpenStreetMap');
  }
}
