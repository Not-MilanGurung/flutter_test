import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController; // nullable, no Completer needed

  String? _mapStyle; // will hold the JSON string once loaded

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.684812666392002, 85.31638349823855),
    zoom: 20,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  Future<void> _loadMapStyle() async {
    try {
      final style = await rootBundle.loadString(
        'assets/map_style/maptheme.json',
      );
      setState(() => _mapStyle = style);
    } catch (e) {
      debugPrint('❗️ Could not load map style: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyle(); // kick off the async load
  }

  Future<void> _applyMapStyle() async {
    if (_mapController != null && _mapStyle != null) {
      await _mapController!.setMapStyle(_mapStyle);
    }
  }

  Future<void> _goToTheLake() async {
    if (_mapController == null) return;
    await _mapController!.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    // While the style is loading we still show the map (plain style).
    // Once `_mapStyle` becomes non‑null we call `_applyMapStyle` in the
    // `onMapCreated` callback.
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Demo')),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        // IMPORTANT: Do NOT pass `style:` here. We set it after the map is ready.
        onMapCreated: (GoogleMapController controller) async {
          _mapController = controller;
          // Apply the style as soon as the controller is available.
          await _applyMapStyle();
        },
        // You can still add markers, polygons, etc. here.
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the native controller to free the Surface/SurfaceTexture.
    _mapController?.dispose();
    super.dispose();
  }
}
