// To parse this JSON data, do
//
//     final weatherHistoryResponse = weatherHistoryResponseFromJson(jsonString);

import 'dart:convert';

WeatherHistoryResponse weatherHistoryResponseFromJson(String str) => WeatherHistoryResponse.fromJson(json.decode(str));

String weatherHistoryResponseToJson(WeatherHistoryResponse data) => json.encode(data.toJson());

class WeatherHistoryResponse {
  String? city;
  WeatherData? weatherData;

  WeatherHistoryResponse({
    this.city,
    this.weatherData,
  });

  factory WeatherHistoryResponse.fromJson(Map<String, dynamic> json) => WeatherHistoryResponse(
    city: json["city"],
    weatherData: json["weather_data"] == null ? null : WeatherData.fromJson(json["weather_data"]),
  );

  Map<String, dynamic> toJson() => {
    "dateTime": city,
    "weather_data": weatherData?.toJson(),
  };
}

class WeatherData {
  int? visibility;
  int? timezone;
  Main? main;
  Clouds? clouds;
  Sys? sys;
  int? dt;
  Coord? coord;
  String? name;
  List<Weather>? weather;
  int? cod;
  int? id;
  String? base;
  Wind? wind;

  WeatherData({
    this.visibility,
    this.timezone,
    this.main,
    this.clouds,
    this.sys,
    this.dt,
    this.coord,
    this.name,
    this.weather,
    this.cod,
    this.id,
    this.base,
    this.wind,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    visibility: json["visibility"],
    timezone: json["timezone"],
    main: json["main"] == null ? null : Main.fromJson(json["main"]),
    clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
    sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
    dt: json["dt"],
    coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
    name: json["name"],
    weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
    cod: json["cod"],
    id: json["id"],
    base: json["base"],
    wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
  );

  Map<String, dynamic> toJson() => {
    "visibility": visibility,
    "timezone": timezone,
    "main": main?.toJson(),
    "clouds": clouds?.toJson(),
    "sys": sys?.toJson(),
    "dt": dt,
    "coord": coord?.toJson(),
    "name": name,
    "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
    "cod": cod,
    "id": id,
    "base": base,
    "wind": wind?.toJson(),
  };
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class Coord {
  double? lon;
  double? lat;

  Coord({
    this.lon,
    this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

class Main {
  double? tempMin;
  int? grndLevel;
  double? temp;
  int? humidity;
  int? pressure;
  int? seaLevel;
  double? tempMax;
  double? feelsLike;

  Main({
    this.tempMin,
    this.grndLevel,
    this.temp,
    this.humidity,
    this.pressure,
    this.seaLevel,
    this.tempMax,
    this.feelsLike,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    tempMin: json["temp_min"]?.toDouble(),
    grndLevel: json["grnd_level"],
    temp: json["temp"]?.toDouble(),
    humidity: json["humidity"],
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    tempMax: json["temp_max"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp_min": tempMin,
    "grnd_level": grndLevel,
    "temp": temp,
    "humidity": humidity,
    "pressure": pressure,
    "sea_level": seaLevel,
    "temp_max": tempMax,
    "feels_like": feelsLike,
  };
}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;
  int? id;
  int? type;

  Sys({
    this.country,
    this.sunrise,
    this.sunset,
    this.id,
    this.type,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    country: json["country"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "sunrise": sunrise,
    "sunset": sunset,
    "id": id,
    "type": type,
  };
}

class Weather {
  String? icon;
  String? description;
  String? main;
  int? id;

  Weather({
    this.icon,
    this.description,
    this.main,
    this.id,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    icon: json["icon"],
    description: json["description"],
    main: json["main"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "description": description,
    "main": main,
    "id": id,
  };
}

class Wind {
  int? deg;
  double? speed;

  Wind({
    this.deg,
    this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    deg: json["deg"],
    speed: json["speed"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "deg": deg,
    "speed": speed,
  };
}
