// import 'package:flutter/material.dart';
// import 'package:weather/widget/weather_widget.dart';


// class CustomSearchDelegate extends SearchDelegate<String> {


//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           // Clear the search bar.
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => Navigator.of(context).pop(),
//       // Exit from the search screen.
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder(
//       // Replace 'YourWeatherData' with the actual type of your weather data
//       future: fetchData.query,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else if (snapshot.hasData) {

//         } else {
//           return Center(
//             child: Text('No data available'),
//           );
//         }
//       },
//     );
//   }
//   @override
//   Widget buildSuggestions(BuildContext context) {
//    return Container();
//   }

// }