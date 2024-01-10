class WeatherModel {
  final String name;
  final double temp_c;

  WeatherModel({
    required this.name,
    required this.temp_c,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['location']['name'] as String,
      temp_c: (json['current']['temp_c'] as num).toDouble(),
    );
  }
}

class SearchWeatherModel {
  final double lat;
  final double lon;

  SearchWeatherModel({
    required this.lat,
    required this.lon,
  });

  factory SearchWeatherModel.fromMap(Map<String, dynamic> json) {
    return SearchWeatherModel(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }
}
