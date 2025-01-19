import 'package:mosam/features/home/respository/models/weather_forcast.dart';

abstract class HomeRepository {
  Future<WeatherForcast> getWeatherForcast(double latitude, double longitude);
}
