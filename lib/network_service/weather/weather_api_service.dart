import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:weather_app/feature/weather_search/model/weather_search_response.dart';
import 'package:weather_app/feature/weather_search/provider/weather_search_provider.dart';

class WeatherApiService {

  static const String apiToken = 'e8ba0400c06fe0a7f0a80b8f21fbdccf';


  static Future<WeatherSearchResponse> fetchWeatherData(
      BuildContext context,
    String lat,
    String lon,

  ) async {

    /// Your OpenWeatherMap API token. Replace with your own key.
    String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiToken';

    /// Fetches weather data for a given location.
    ///
    /// This method takes the context, latitude, and longitude as parameters.
    /// It constructs the API URL, fetches data using http.get, and parses the response.
    ///
    /// - On success (status code 200): Decodes the JSON response, sets the data in the WeatherSearchProvider,
    ///   and returns a WeatherSearchResponse object.
    /// - On failure: Throws an exception with an informative message.
    final url = Uri.parse(apiUrl);

    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      context.read<WeatherSearchProvider>().setTempWeatherJson(data);
      return WeatherSearchResponse.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather data: ${response.statusCode}');
    }
  }



}
