import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/models/weather_model.dart';
import 'package:http/http.dart' as http;

class CallToApi {
  // Add your API key here
  final String apiKey = "dfc5d7498amsh7ede97992791989p1ec447jsn8bdb681153f5";

  Future<WeatherModel> callWeatherAPI(bool current, String cityName) async {
    try {
      Position currentPosition = await getCurrentPosition();

      if (current) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude,
          currentPosition.longitude,
        );

        Placemark place = placemarks[0];
        cityName = place.locality!;
      }

      var url = Uri.parse(
        'https://weatherapi-com.p.rapidapi.com/current.json?q=$cityName',
      );

      final http.Response response = await http.get(url, headers: {
        // Add your API key to the headers
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com',
        'X-RapidAPI-Key': 'dfc5d7498amsh7ede97992791989p1ec447jsn8bdb681153f5',
      });

      log(response.body.toString());

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return WeatherModel.fromMap(decodedJson);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
