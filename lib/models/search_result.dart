class SearchModel {
  final double temp; // Change Double to double
  final String name;

  SearchModel({
    required this.temp,
    required this.name,
  });

    double getTemperatureInCelsius() {
    return (temp - 32) * 5 / 9;
  }

  factory SearchModel.fromMap(Map<String, dynamic> json) {
    return SearchModel(
      temp: json['main']['temp'].toDouble(), // Convert to double
      name: json['name'] as String,
    );
  }
}
