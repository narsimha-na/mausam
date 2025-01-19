class UrlConstants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static String getWeaterByLocation(
          {required double lat, required double lon, required String apiId}) =>
      '${baseUrl}onecall?lat=$lat&lon=$lon&units=metric&appid=$apiId';

  static String searchCityName(
          {required String cityName, required String apiId}) =>
      '${baseUrl}find?q=$cityName&units=metric&appid=$apiId';
}
