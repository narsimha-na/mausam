import 'package:mosam/core/constants/assets_constants.dart';
import 'package:mosam/core/functions/timestamp_functions.dart';

class TemperatureFunctions {
  static String getTemperature(
      {required num tempertature, required bool isCelsius}) {
    return isCelsius
        ? ("${tempertature.toStringAsFixed(1)} °C")
        : ("${((tempertature * 9 / 5) + 32).toStringAsFixed(1)} °F");
  }

  static String getImagePath(
      {required String weatherDescription,
      required int timeStamp,
      required int offset}) {
    bool isDay = (TimeFunctions.getDateTimeFromTimestamp(
                    timestamp: timeStamp, offset: offset)
                .hour >=
            6 &&
        TimeFunctions.getDateTimeFromTimestamp(
                    timestamp: timeStamp, offset: offset)
                .hour <
            18);
    switch (weatherDescription.toLowerCase()) {
      case 'clear sky':
        return isDay ? ImageConstants.sun : ImageConstants.nightMoon;
      case 'few clouds':
      case 'clouds':
        return isDay ? ImageConstants.partlyCloudy : ImageConstants.nightCloudy;
      case 'scattered clouds':
      case 'broken clouds':
        return ImageConstants.cloudy;
      case 'shower rain':
      case 'rain':
        return ImageConstants.rain;
      case 'thunderstorm':
        return ImageConstants.lightning;
      case 'snow':
        return ImageConstants.snow;
      case 'mist':
      case 'fog':
        return isDay ? ImageConstants.foggySun : ImageConstants.nightFog;
      case 'haze':
        return isDay
            ? ImageConstants.foggySun
            : ImageConstants.nightFog; // Assuming haze is similar to fog
      case 'dust':
      case 'sand':
        return ImageConstants.cloudy; // Default for dust/sand
      case 'tornado':
        return ImageConstants.lightning; // Assuming tornado is severe weather
      default:
        return isDay
            ? ImageConstants.sun
            : ImageConstants.nightMoon; // Default image if no match found
    }
  }
}
