import 'package:farukhelp/Views/locationService.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Lokasyon extends StatefulWidget {
  const Lokasyon({Key? key}) : super(key: key);

  @override
  _LokasyonState createState() => _LokasyonState();
}

class _LokasyonState extends State<Lokasyon> {
  String? lat, long, country, adminArea;
  int distance = 0;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location Info:',
              style: getStyle(size: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Latitude: ${lat ?? 'Loading ...'}',
              style: getStyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Longitude: ${long ?? 'Loading ...'}',
              style: getStyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Country: ${country ?? 'Loading ...'}',
              style: getStyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Admin Area: ${adminArea ?? 'Loading ...'}',
              style: getStyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Distance: ${distance}')
          ],
        ),
      ),
    );
  }

  TextStyle getStyle({double size = 20}) =>
      TextStyle(fontSize: size, fontWeight: FontWeight.bold);

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    double distanceMetre = await Geolocator.distanceBetween(
        locationData?.latitude ?? 0,
        locationData?.longitude ?? 0,
        41.439138538347315,
        31.754023855210175);

    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        lat = locationData.latitude!.toStringAsFixed(2);
        long = locationData.longitude!.toStringAsFixed(2);
        distance = (distanceMetre / 1000).toInt();
        country = placeMark?.country ?? 'could not get country';
        adminArea = placeMark?.administrativeArea ?? 'could not get admin area';
      });
    }
  }
}
