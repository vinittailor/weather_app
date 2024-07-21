class Images {

  static String airPressureBlack = "air_pressure_black".svg;
  static String airPressureWhite = "air_pressure_white".svg;
  static String humidityBlack = "humidity_black".svg;
  static String humidityWhite = "humidity_white".svg;
  static String sunBlack = "sun_black".svg;
  static String sunWhite = "sun_white".svg;
  static String sunRiseBlack = "sun_rise_black".svg;
  static String sunRiseWhite = "sun_rise_white".svg;
  static String sunSetBlack = "sun_set_black".svg;
  static String sunSetWhite = "sun_set_white".svg;
  static String temperatureBlack = "temperature_black".svg;
  static String temperatureWhite = "temperature_white".svg;
  static String visibilityBlack = "visibility_black".svg;
  static String visibilityWhite = "visibility_white".svg;
  static String windBlack = "wind_black".svg;
  static String windWhite = "wind_white".svg;


  static String clearSkyD = "clear_sky_d".png;
  static String clearSkyN = "clear_sky_n".png;

  static String fewCloudsD = "few_clouds_d".png;
  static String fewCloudsN = "few_clouds_n".png;

  static String scatteredCloudsD = "scattered_clouds_d".png;
  static String scatteredCloudsN = "scattered_clouds_n".png;

  static String brokenClouds = "broken_clouds".png;

  static String showerRain = "shower_rain".png;

  static String rainD = "rain_d".png;
  static String rainN = "rain_n".png;

  static String thunderstorm = "thunderstorm".png;

  static String haze = "haze".png;
  static String snow = "snow".png;

  /// A map that associates weather condition codes with their corresponding image asset paths
  static final iconMap = {
    '01d': clearSkyD,
    '01n': clearSkyN,
    '02d': fewCloudsD,
    '02n': fewCloudsN,
    '03d': scatteredCloudsD,
    '03n': scatteredCloudsN,
    '04d': brokenClouds,
    '04n': brokenClouds,
    '09d': showerRain,
    '09n': showerRain,
    '10d': rainD,
    '10n': rainN,
    '11d': thunderstorm,
    '11n': thunderstorm,
    '13d': snow,
    '13n': snow,
    '50d': haze,
    '50n': haze,
  };

  /// Retrieves the image asset path for a given weather condition code.
  ///
  /// If the code is not found in the map, defaults to 'clearSkyN.png'.
  static String getWeatherIconPath(String iconCode) {
    return iconMap[iconCode] ?? clearSkyN;
  }


}

/// Extension methods for String class to simplify accessing image assets.
extension Img on String {
  /// Returns the URL for an image on the OpenWeatherMap website (assuming PNG format).
  String get netPng => 'https://openweathermap.org/img/wn/$this.png';

  /// Returns the asset path for an SVG image located in the 'assets/images' directory.
  String get svg => 'assets/images/$this.svg';

  /// Returns the asset path for a PNG image located in the 'assets/images' directory.
  String get png => 'assets/images/$this.png';
}


