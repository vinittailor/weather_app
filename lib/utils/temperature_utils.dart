import 'dart:math';

class TemperatureUtils {
  /// Converts Kelvin temperature to Celsius.
  ///
  /// Takes a Kelvin temperature as input and returns the equivalent Celsius temperature as an integer.
  /// The calculation rounds the result to the nearest integer.
  static int kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).round();
  }

  /// Converts meters per second to miles per hour.
  ///
  /// Takes a speed in meters per second as input and returns the equivalent speed in miles per hour as an integer.
  /// Uses a constant conversion factor for accuracy. The result is rounded to the nearest integer.
  static int metersPerSecondToMilesPerHour(double metersPerSecond) {
    const conversionFactor = 2.23694;
    return (metersPerSecond * conversionFactor).round();
  }
}
