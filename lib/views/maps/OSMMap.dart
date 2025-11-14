import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cis099_2/views/maps/mapspage.dart';

class OsmmapScreen extends StatefulWidget {
  const OsmmapScreen({super.key});

  @override
  State<OsmmapScreen> createState() => _OsmmapScreenState();
}

class _OsmmapScreenState extends State<OsmmapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute<void>(builder: (context) => MapsPage()));
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(37.7749, -122.42),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'np.patancollege.my_ap',
          ),
        ],
      ),
    );
  }
}
