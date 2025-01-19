import 'package:mosam/core/constants/string_constants.dart';
import 'package:mosam/core/env/env.dart';
import 'package:mosam/features/home/respository/home_repository.dart';
import 'package:mosam/features/home/respository/models/weather_forcast.dart';
import 'package:mosam/service/network.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkService _networkService;

  HomeRepositoryImpl(this._networkService);

  @override
  Future<WeatherForcast> getWeatherForcast(
      double latitude, double longitude) async {
    final response = await _networkService.get(
      UrlConstants.getWeaterByLocation(
        lat: latitude,
        lon: longitude,
        apiId: Env.weatherApiKey,
      ),
    );
    if (response.statusCode == 200) {
      return WeatherForcast.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather forcast');
    }
  }
}
