import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import '../viewmodels/mapController.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapViewModel(),
      child: const _MapPageContent(),
    );
  }
}

class _MapPageContent extends StatelessWidget {
  const _MapPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapViewModel>(context);
    
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: viewModel.mapController,
            options: MapOptions(
              initialCenter: viewModel.currentLocation,
              initialZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: viewModel.markers,
              ),
              CircleLayer<Object>(
                circles: [
                  CircleMarker<Object>(
                    point: viewModel.currentLocation,
                    color: Colors.blue,
                    radius: 10,
                  ),
                ],
              ),
            ],
          ),
          const Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: SearchBar(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.moveToCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}