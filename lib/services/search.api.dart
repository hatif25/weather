import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:weather/models/search_result.dart';

class SearchApi {
  static const String apiKey = 'dfc5d7498amsh7ede97992791989p1ec447jsn8bdb681153f5';
  static const String apiHost = 'open-weather13.p.rapidapi.com';
  static const String baseUrl = 'https://open-weather13.p.rapidapi.com';

  Future<SearchModel> callSearchApi(String city) async {
    final String endpoint = '/city/$city';

    var url = Uri.parse('$baseUrl$endpoint');

    final response = await http.get(url, headers: {
      'X-RapidAPI-Host': apiHost,
      'X-RapidAPI-Key': apiKey,
    });

    if (response.statusCode == 200) {
      print('API Response: ${response.body.toString()}');
      final Map<String, dynamic> data = json.decode(response.body);
      // Assuming you have a factory method in SearchModel for creating an instance from the API response
      return SearchModel.fromMap(data);
    } else {
      // Handle errors, you might want to throw an exception or return an error model
      throw Exception('Failed to fetch data. ${response.statusCode}');
    }
  }
}

void main() async {
  SearchApi searchApi = SearchApi();

  try {
    // Example usage
   SearchModel searchResult = await searchApi.callSearchApi('hyderabad');
    print(searchResult);
  } catch (error) {
    print('Error: $error');
  }
}
