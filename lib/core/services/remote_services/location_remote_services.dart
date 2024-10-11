import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:travelapp/core/api/api_constants.dart';
import 'package:travelapp/features/home/data/model/wether_model.dart';

class LocationRemoteServices {
  final String apiKey = 'b1b15e88fa797225412429c1c50c122a1';

  Future<Weather?> fetchWeatherByCurrentLocation(
      double latitude, double longitude) async {
    final url = Uri.parse(
        "${ApiConstants.openWeatherMapUrl}weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      if (kDebugMode) {
        print('Failed to load weather data');
      }
      return null;
    }
  }
}
