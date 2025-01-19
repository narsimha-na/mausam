import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mosam/core/constants/assets_constants.dart';
import 'package:mosam/core/db/db.dart';
import 'package:mosam/core/functions/temperature_functions.dart';
import 'package:mosam/core/functions/timestamp_functions.dart';
import 'package:mosam/features/home/respository/home_repository_impl.dart';
import 'package:mosam/features/home/respository/models/daily_weather_forecast.dart';
import 'package:mosam/features/home/respository/models/search_model.dart';
import 'package:mosam/features/home/respository/models/weather_forcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherProvider with ChangeNotifier {
  final HomeRepositoryImpl repository;
  final Db db;
  WeatherForcast? _weatherForcast;
  WeatherForcast? get weatherForcast => _weatherForcast;
  bool _isLoading = false;

  String cityName = 'Hyderabad';
  String countryName = 'IN';
  bool isCelsius = true;
  String weatherDescription = '';
  String weatherTemp = '';
  String weatherIcon = ImageConstants.sun;
  String weatherFeelsLike = '';
  String weatherHumidity = '0';
  String weatherWindSpeed = '0';
  String weatherSunrise = '0';
  String weatherSunset = '0';
  List<DailyWeatherForecast> dailyWeatherForecast = [];

  bool get isLoading => _isLoading;
  WeatherProvider({required this.repository, required this.db}) {
    fetchInitialCalls();
  }

  Future<void> fetchWeather(double latitude, double longitude) async {
    try {
      setIsLoading(true);
      _weatherForcast = await repository.getWeatherForcast(latitude, longitude);
      setWeatherDetails(_weatherForcast!);
      setIsLoading(false);
      notifyListeners();
    } catch (e) {
      setIsLoading(false);
    }
  }

  Future<void> fetchInitialCalls() async {
    try {
      await db.getSearchModel().then((SearchModel value) async {
        log("value: ${value.toString()}");
        cityName = value.cityName;
        countryName = value.countryName;

        await fetchWeather(value.latitude, value.longitude);
        setIsCelsius(value.isCelsius);
        notifyListeners();
      });
    } catch (e) {
      setIsLoading(false);
      log("error: $e");
      Exception(e);
    }
  }

  void setWeatherDetails(WeatherForcast weatherForcast) {
    weatherDescription = weatherForcast.current?.weather?[0].main ?? '';
    weatherTemp = TemperatureFunctions.getTemperature(
        tempertature: weatherForcast.current?.temp ?? 0, isCelsius: isCelsius);
    weatherIcon = TemperatureFunctions.getImagePath(
        weatherDescription: weatherDescription,
        timeStamp: weatherForcast.current!.dt!.toInt(),
        offset: weatherForcast.timezoneOffset!.toInt());
    weatherFeelsLike =
        "${TemperatureFunctions.getTemperature(tempertature: weatherForcast.current?.temp ?? 0, isCelsius: isCelsius)} Feels like ${TemperatureFunctions.getTemperature(tempertature: weatherForcast.current?.feelsLike ?? 0, isCelsius: isCelsius)}";
    weatherHumidity = "${weatherForcast.current?.humidity.toString() ?? '0'} %";
    weatherWindSpeed =
        "${weatherForcast.current?.windSpeed.toString() ?? '0'} m/s";
    weatherSunrise = TimeFunctions.getTimeFromTimestamp(
        timestamp: weatherForcast.current!.sunrise!,
        offset: weatherForcast.timezoneOffset!.toInt());
    weatherSunset = TimeFunctions.getTimeFromTimestamp(
        timestamp: weatherForcast.current!.sunset!,
        offset: weatherForcast.timezoneOffset!.toInt());
    dailyWeatherForecast = setDailyWeatherForecast();
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsCelsius(bool val) {
    isCelsius = val;
    db.getSearchModel().then((value) {
      db.saveSearchModel(
        SearchModel(
          cityName: value.cityName,
          countryName: value.countryName,
          latitude: value.latitude,
          longitude: value.longitude,
          isCelsius: val,
        ),
      );
    });
    setWeatherDetails(_weatherForcast!);
    notifyListeners();
  }

  List<DailyWeatherForecast> setDailyWeatherForecast() {
    dailyWeatherForecast = [];
    if (weatherForcast!.daily!.length > 4) {
      for (int i = 0; i < 3; i++) {
        dailyWeatherForecast.add(
          DailyWeatherForecast(
            date: TimeFunctions.getDayFromTimestamp(
                timestamp: weatherForcast!.daily![i].dt!,
                offset: weatherForcast!.timezoneOffset!.toInt()),
            weatherDescription:
                weatherForcast!.daily![i].weather?[0].main ?? '',
            dailyWeatherForecastDetails:
                getHourlyWeatherForcast(weatherForcast!.daily![i].dt!.toInt()),
          ),
        );
      }
    }
    return dailyWeatherForecast;
  }

  List<DailyWeatherForecastDetails> getHourlyWeatherForcast(
      int dailyWeatherForecast) {
    List<DailyWeatherForecastDetails> hourlyWeatherForecast = [];
    DateTime dailyDate = TimeFunctions.getDateTimeFromTimestamp(
        timestamp: dailyWeatherForecast,
        offset: weatherForcast!.timezoneOffset!.toInt());

    for (var element in weatherForcast!.hourly!) {
      DateTime hourlyDate = TimeFunctions.getDateTimeFromTimestamp(
          timestamp: element.dt!.toInt(),
          offset: weatherForcast!.timezoneOffset!.toInt());

      if (hourlyDate.year == dailyDate.year &&
          hourlyDate.month == dailyDate.month &&
          hourlyDate.day == dailyDate.day) {
        hourlyWeatherForecast.add(
          DailyWeatherForecastDetails(
            temperature: TemperatureFunctions.getTemperature(
                tempertature: element.temp ?? 0, isCelsius: isCelsius),
            date: TimeFunctions.getTimeFromTimestamp(
                timestamp: element.dt!.toInt(),
                offset: weatherForcast!.timezoneOffset!.toInt()),
            imgPath: TemperatureFunctions.getImagePath(
                weatherDescription: element.weather?[0].main ?? '',
                timeStamp: element.dt!.toInt(),
                offset: weatherForcast!.timezoneOffset!.toInt()),
          ),
        );
      }
    }
    return hourlyWeatherForecast;
  }

  void setCityName(String cityName) {
    this.cityName = cityName;
    notifyListeners();
  }

  void setCountryName(String countryName) {
    this.countryName = countryName;
    notifyListeners();
  }
}
