import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/feature/weather_search/model/weather_search_response.dart';
import 'package:weather_app/network_service/location/location_service.dart';
import 'package:weather_app/network_service/weather/weather_api_service.dart';

class WeatherSearchProvider with ChangeNotifier {

  String _lat = "";
  String get lat => _lat;
  String _lon = "";
  String get log => _lon;

  Map<String,dynamic> tempWeatherJson = {};

  void setTempWeatherJson(var json){
    tempWeatherJson = json;
    notifyListeners();
  }

  TextEditingController cityController = TextEditingController();


  WeatherSearchResponse? _weatherSearchResponse;
  WeatherSearchResponse? get weatherSearchResponse => _weatherSearchResponse;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  void findCurrentLocation(BuildContext context) async {
    var location = await LocationService.getCurrentLocation();
    _lat = location.latitude.toString();
    _lon = location.longitude.toString();
    notifyListeners();

    if(context.mounted){
      fetchWeatherData(context,_lat,_lon);
    }


  }

  void findLocationFromCity(BuildContext context) async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult[0] == ConnectivityResult.none) {
      _errorMessage = 'No internet connection';
      notifyListeners();
      return;
    }

    var location = await LocationService.getLocationsFromAddress(cityController.text.trim());
    _lat = location[0].latitude.toString();
    _lon = location[0].longitude.toString();
    notifyListeners();

    if(context.mounted){
      fetchWeatherData(context,_lat,_lon);
    }


  }


  Future<void> fetchWeatherData(BuildContext context,String lat, String lon,) async {
    _isLoading = true; // Set loading state to true

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult[0] == ConnectivityResult.none) {
        _errorMessage = 'No internet connection';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Fetch data from the API using WeatherApiService
      final response = await WeatherApiService.fetchWeatherData(context,_lat,_lon);
      _weatherSearchResponse = response;
      _errorMessage = ""; // Clear any previous error message

      // Handle successful response
      if (response.cod == 200) {
        // Handle success scenario (e.g., update UI)
      } else {
        // Show error snackbar if context is valid
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Fail to get weather data"),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } on Exception catch (error) {
      _errorMessage = error.toString(); // Set error message
      // Show error snackbar if context is valid
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: $_errorMessage'),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      _isLoading = false; // Set loading state to false
      notifyListeners(); // Notify listeners about changes
    }
  }

  Future<void> saveWeatherData(BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    // final timestamp = DateTime.now();
    // final formattedTimestamp = timestamp.millisecondsSinceEpoch.toString();
    String cityName = _weatherSearchResponse?.name ?? "";

    try {
      await firestore.collection('weatherData').doc(cityName).set({"city" : cityName,
      "weather_data": tempWeatherJson
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Weather data saved successfully"),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
          ),
        );
      }
      if (kDebugMode) {
        print('Weather data saved successfully');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (kDebugMode) {
        print('Error saving weather data: $e');
      }
    }
  }


}