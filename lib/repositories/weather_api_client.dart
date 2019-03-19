import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/models.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocation(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> getCity(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await httpClient.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}
