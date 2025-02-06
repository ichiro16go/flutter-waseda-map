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
  Map<String, dynamic>? selectedRestaurant;
  var showBottomSheet = false;
  var sheetPosition = 0.3;
  final dragSensitivity = 600;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    mapController = MapController();
  }
//現在地情報の取得
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

//レストランの情報取得
  Future<List<Map<String, dynamic>>> fetchRestaurants(
      double south, double west, double north, double east) async {
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

//マーカーの追加
  Future addMarkers() async {
    final restaurants = await fetchRestaurants(
        currentLocation.latitude - 0.004,
        currentLocation.longitude - 0.004,
        currentLocation.latitude + 0.004,
        currentLocation.longitude + 0.004);

    setState(() {
      markers.addAll(
        restaurants.map((restaurant) {
          return Marker(
            point: LatLng(restaurant['lat'], restaurant['lon']),
            width: 80.0,
            height: 80.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedRestaurant = restaurant;
                  showBottomSheet = true;
                });
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

      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
          if (showBottomSheet)
            DraggableScrollableSheet(
              initialChildSize: sheetPosition, // 初期高さ
              minChildSize: 0.1, // 最小高さ
              maxChildSize: 1.0, // 最大高さ
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Grabber(
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          setState(() {
                            sheetPosition -= details.delta.dy / dragSensitivity;
                            if (sheetPosition < 0.25) {
                              sheetPosition = 0.25;
                            }
                            if (sheetPosition > 1.0) {
                              sheetPosition = 1.0;
                            }
                          });
                        },
                        onVerticalDragEnd: (DragEndDetails details) {
                          setState(() {
                            if (sheetPosition < 0.6) {
                              sheetPosition = 0.3;
                            } else {
                              sheetPosition = 0.95;
                            }
                          });
                        },
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.05),
                          children: [
                            if (selectedRestaurant != null) ...[
                              Text(
                                selectedRestaurant!['name'],
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  ElevatedButton(
                                    child: const Text('経路'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 81, 44, 242),
                                      foregroundColor: Colors.white,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 8.0),
                                  ElevatedButton(
                                    child: const Text('共有'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text("Insert images here"),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text('系統: ${selectedRestaurant!['cuisine']}'),
                              SizedBox(height: 8.0),
                              Text(
                                  '座標: (${selectedRestaurant!['lat']}, ${selectedRestaurant!['lon']})'),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showBottomSheet = false;
                                  });
                                },
                                child: Text('閉じる'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 現在地を取得するロジックをここに実装
          getCurrentPosition();
          mapController.move(currentLocation, 18.0);
        },
        backgroundColor: const Color.fromRGBO(155, 0, 63, 1),
        child: const Icon(Icons.my_location,color: Colors.white,),
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
    required this.onVerticalDragEnd,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final ValueChanged<DragEndDetails> onVerticalDragEnd;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 32.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
