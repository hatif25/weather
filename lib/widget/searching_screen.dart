import 'package:flutter/material.dart';
import 'package:weather/models/search_result.dart';
import 'package:weather/services/search.api.dart';

class SearchingScreen extends StatefulWidget {
  @override
  _SearchingScreenState createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  TextEditingController searchController = TextEditingController();
  SearchModel? searchResult;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    contentPadding: EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchCity();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : searchResult != null
                        ? Column(
                            children: [
                              Text(
                                searchResult?.name ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Temperature: ${searchResult?.getTemperatureInCelsius().toStringAsFixed(2)}°C",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'City not found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchCity() async {
    setState(() {
      isLoading = true;
      searchResult = null;
    });

    SearchApi searchApi = SearchApi();

    try {
      SearchModel result = await searchApi.callSearchApi(searchController.text);
      setState(() {
        searchResult = result;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error, you might want to show a snackbar or display an error message
      print('Error: $error');
    }
  }
}
