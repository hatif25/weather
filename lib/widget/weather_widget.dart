import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather.api.dart';
import 'package:weather/widget/search_widget.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherModel? weatherData; // Allow for null until data is fetched
  bool isLoading = false; // Add a flag to track loading state

  @override
  void initState() {
    super.initState();
    // Initialize weatherData to avoid late initialization issues
    weatherData = WeatherModel(name: '', temp_c: 0.0);
    fetchData(); // Call the method to fetch data when the widget is created
  }

  Future<void> fetchData() async {
    if (isLoading) return; // Avoid making a new API call while one is in progress
    setState(() {
      isLoading = true;
    });

    CallToApi apiCaller = CallToApi();
    try {
      WeatherModel _data = await apiCaller.callWeatherAPI(true, 'CityName');
      setState(() {
        weatherData = _data;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        weatherData = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   onPressed: () async {
      //     await showSearch(
      //       context: context,
      //       delegate: CustomSearchDelegate(),
      //     );
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherData?.name ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${weatherData?.temp_c}°C",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
    ));
    
     }   
    
  }

