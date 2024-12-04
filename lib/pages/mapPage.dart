import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../utils/position.dart';
import 'package:geolocator/geolocator.dart';
import '../compornents/searchBox.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng currentLocation = LatLng(0, 0);
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    mapController = MapController();
  }

  void getCurrentPosition() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('位置情報サービスが無効です。');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('位置情報のパーミッションが拒否されました。');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('位置情報のパーミッションが永久に拒否されました。');
    }

    var position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
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
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              CircleLayer<Object>(
                circles: [
                  CircleMarker<Object>(
                    point: currentLocation,
                    color: Colors.blue,
                    radius: 10,
                  ),
                ],
              ),
            ],
          ),
          const Positioned(
            top: 20, // 適宜調整してください
            left: 20, // 適宜調整してください
            right: 20, // 適宜調整してください
            child: SearchBar(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentPosition();
          mapController.move(currentLocation, 18.0);
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
