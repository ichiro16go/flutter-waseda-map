import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../utils/position.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng currentLocation;
  late MapController mapController;
  final List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    mapController = MapController();
  }

  void getCurrentPosition() async {
    // 位置情報サービスが有効かどうかを確認
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // サービスが無効な場合は、ユーザーに有効化を求める
      return Future.error('位置情報サービスが無効です。');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // パーミッションが拒否された場合はエラー
        return Future.error('位置情報のパーミッションが拒否されました。');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // パーミッションが永久に拒否された場合はエラー
      return Future.error('位置情報のパーミッションが永久に拒否されました。');
    } 

    // 現在の位置を取得
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      addMarkers();
    });
  }

  Future<List<Map<String, dynamic>>> fetchRestaurants(double south, double west, double north, double east) async {
    // Overpass APIのエンドポイント
    final url = Uri.parse('https://overpass-api.de/api/interpreter');

    // Overpass APIクエリ
    final query = '''
    [out:json];
    node["amenity"="restaurant"]($south,$west,$north,$east);
    out body;
    ''';

    // APIリクエスト
    final response = await http.post(url, body: {'data': query});

    // 結果をパース
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final elements = data['elements'] as List;
      // 必要な情報を抽出してリスト化
      return elements
          .map((element) => {
                'id': element['id'],
                'name': element['tags']?['name'] ?? 'Unnamed',
                'cuisine': element['tags']?['cuisine'] ?? ['Unknown Cuisine'],
                'lat': element['lat'],
                'lon': element['lon'],
              })
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future addMarkers() async{
    final restaurants = await fetchRestaurants(currentLocation.latitude-0.004, currentLocation.longitude-0.004, currentLocation.latitude+0.004, currentLocation.longitude+0.004);

    setState(() {
      markers.addAll(
        restaurants.map((restaurant) {
          return Marker(
            point: LatLng(restaurant['lat'], restaurant['lon']),
            width: 80.0,
            height: 80.0,
            child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('店舗情報'),
                  content: Text(
                      '店名: ${restaurant['name']}\n系統: ${restaurant['cuisine']}\n座標: (${restaurant['lat']}, ${restaurant['lon']})'),
                ),
              );
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40.0,
            ),
          ),
            
          );
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation,
          initialZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          CircleLayer<Object>(
            circles: [
              CircleMarker<Object>(
                //現在地アイコン
                point: currentLocation,
                color: Colors.blue,
                radius: 10,
              ),
            ],
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // 現在地を取得するロジックをここに実装
          getCurrentPosition();
          mapController.move(currentLocation, 18.0);
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}