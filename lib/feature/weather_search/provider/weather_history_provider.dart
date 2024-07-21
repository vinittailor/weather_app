import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/feature/weather_search/model/weather_history_response.dart';
import 'package:weather_app/utils/temperature_utils.dart';

class WeatherHistoryProvider with ChangeNotifier {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;
  bool _isLoading = false;

  bool _isFilterVisible = false;
  bool get isFilterVisible => _isFilterVisible;

  bool get isLoading => _isLoading;
  List<WeatherHistoryResponse> _weatherHistoryResponse =
      List.empty(growable: true);
  List<WeatherHistoryResponse> _weatherHistoryFilterResponse =
      List.empty(growable: true);

  List<WeatherHistoryResponse> get weatherHistoryResponse =>
      _weatherHistoryResponse;

  List<WeatherHistoryResponse> get weatherHistoryFilterResponse =>
      _weatherHistoryFilterResponse;

  TextEditingController filterController = TextEditingController();
  String filterValue = "None";

  List<String> filterList = [
    "None",
    "City",
    "Temperature",
    "Humidity",
    "Wind",
  ];

  void toggleFilterVisibility(){
    _isFilterVisible = !_isFilterVisible;
    if(!_isFilterVisible){
      resetFilter();
    }
  notifyListeners();
  }

  void setDropDownValue(String value){
    filterValue = value;
    setFilter(filterController.text);
  notifyListeners();
  }


  void resetFilter(){
    _weatherHistoryFilterResponse =_weatherHistoryResponse;
  }

  void setFilter(String value) {

    switch(filterValue){
      case "None":
        _weatherHistoryFilterResponse = _weatherHistoryResponse;
        notifyListeners();
        break;
      case "City":
        _weatherHistoryFilterResponse = _weatherHistoryResponse.where((weather) {
          return weather.city!.toLowerCase().contains(value.toLowerCase());
        }).toList();
        notifyListeners();

        break;
      case "Temperature":
        _weatherHistoryFilterResponse = _weatherHistoryResponse.where((weather) {
          return TemperatureUtils.kelvinToCelsius(weather.weatherData?.main?.temp ?? 0.0).toString().toLowerCase().contains(value.toLowerCase());
        }).toList();
        notifyListeners();
        break;
      case "Humidity":
        _weatherHistoryFilterResponse = _weatherHistoryResponse.where((weather) {
          return weather.weatherData!.main!.humidity!.toString().toLowerCase().contains(value.toLowerCase());
        }).toList();
        notifyListeners();
        break;
      case "Wind":
        _weatherHistoryFilterResponse = _weatherHistoryResponse.where((weather) {
          return weather.weatherData!.wind!.toString().toLowerCase().contains(value.toLowerCase());
        }).toList();
        notifyListeners();
        break;
    }

  }


  Future<void> pullRefresh() async {
    loadSavedWeatherData();
  }

  void clearVariable(){
    _isFilterVisible = false;
    _isLoading = false;
    _errorMessage = "";
    _weatherHistoryFilterResponse.clear();
    _weatherHistoryResponse.clear();
  }


  Future<void> loadSavedWeatherData() async {
    _isLoading = true;
    _weatherHistoryResponse.clear();
    _weatherHistoryFilterResponse.clear();
    _errorMessage = "";
    try {

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult[0] == ConnectivityResult.none) {
        _errorMessage = 'No internet connection';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final userDoc = FirebaseFirestore.instance.collection('weatherData');
      final docSnapshot = await userDoc.get();
      if (docSnapshot.size > 0) {
        final data = docSnapshot;
        for (var doc in data.docs) {
          if (kDebugMode) {
            print("${doc.id} => ${jsonEncode(doc.data())}");
          }

          try {
            final weatherData = WeatherHistoryResponse.fromJson(doc.data());
            _weatherHistoryResponse.add(weatherData);

          } catch (e) {
            if (kDebugMode) {
              print('Error parsing document: $e');
            }
          }
        }
        _weatherHistoryFilterResponse = _weatherHistoryResponse;
        notifyListeners();
      } else {
        // Handle case where user document doesn't exist
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      // Handle errors
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
