import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Gets the current location of the device.
  ///
  /// Checks for location service enabled, required permissions, and returns the current position.
  /// If any errors occur, returns a Future.error with an appropriate message.

  static Future<Position> getCurrentLocation() async {
    if (kDebugMode) {
      print("I am in getCurrentLocation");
    }

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// Gets a list of locations based on a given address.
  ///
  /// Uses the geocoding package to convert the address to a list of locations.
  /// Returns an empty list if an error occurs.
  static Future<List<Location>> getLocationsFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      return locations;
    } catch (e) {
      return [];
    }
  }
}
