import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapViewModel extends ChangeNotifier {
  late LatLng currentLocation = LatLng(0, 0);
  final List<Marker> markers = [];
  late MapController mapController;

  MapViewModel() {
    mapController = MapController();
    getCurrentPosition();
  }

  //現在地の取得(1度目)
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
    currentLocation = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }
  //現在地の取得(２回目以降)
  void moveToCurrentLocation() {
    getCurrentPosition();
    mapController.move(currentLocation, 18.0);
  }
  //マーカーの追加
  void addMarker(int number, LatLng latlng) {
    final Icon icon = Icon(
      Icons.place,
      color: number == 0 ? Colors.green : Colors.pink,
      size: 40,
    );
    markers.add(Marker(point: latlng, child: icon));
    notifyListeners();
  }
  //

}