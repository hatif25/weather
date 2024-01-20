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

