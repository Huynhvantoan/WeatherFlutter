import 'package:meta/meta.dart';
import 'package:weather/models/models.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationID = await weatherApiClient.getLocation(city);
    return await weatherApiClient.getCity(locationID);
  }
}
