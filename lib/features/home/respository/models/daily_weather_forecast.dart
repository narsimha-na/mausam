class DailyWeatherForecast {
  final String date;
  final String weatherDescription;
  final List<DailyWeatherForecastDetails> dailyWeatherForecastDetails;

  DailyWeatherForecast({
    required this.date,
    required this.weatherDescription,
    required this.dailyWeatherForecastDetails,
  });

  @override
  String toString() {
    return 'DailyWeatherForecast(date: $date, weatherDescription: $weatherDescription, dailyWeatherForecastDetails: $dailyWeatherForecastDetails)';
  }
}

class DailyWeatherForecastDetails {
  final String date;
  final String temperature;
  final String imgPath;

  DailyWeatherForecastDetails({
    required this.date,
    required this.temperature,
    required this.imgPath,
  });

  @override
  String toString() {
    return 'DailyWeatherForecastDetails(date: $date, temperature: $temperature, imgPath: $imgPath)';
  }
}
