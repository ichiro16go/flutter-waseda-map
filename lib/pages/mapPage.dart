import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../utils/position.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng currentLocation;
  late MapController mapController;

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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 現在地を取得するロジックをここに実装
          getCurrentPosition();
          mapController.move(currentLocation, 18.0);
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
